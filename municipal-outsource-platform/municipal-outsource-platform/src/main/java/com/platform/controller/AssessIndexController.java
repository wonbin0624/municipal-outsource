package com.platform.controller;

import com.platform.common.Result;
import com.platform.entity.AssessIndex;
import com.platform.service.AssessIndexService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.cache.annotation.CacheEvict;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/api/assess")
@CrossOrigin
public class AssessIndexController {

    @Autowired
    private AssessIndexService assessIndexService;

    // ==================== 改动① 加缓存注解 ====================
    @Cacheable(value = "assessIndex", key = "'all'")
    @GetMapping("/list")
    public Result<List<AssessIndex>> list() {
        return Result.success(assessIndexService.list());
    }

    // ==================== 改动② 清除缓存 ====================
    @CacheEvict(value = "assessIndex", allEntries = true)
    @PostMapping("/add")
    public Result<String> add(@RequestBody AssessIndex assessIndex) {
        // 校验权重不能为空且大于0
        if (assessIndex.getWeight() == null || assessIndex.getWeight().compareTo(BigDecimal.ZERO) <= 0) {
            return Result.error("权重必须大于0");
        }

        // 查询所有已启用的指标
        QueryWrapper<AssessIndex> wrapper = new QueryWrapper<>();
        wrapper.eq("status", 1);
        List<AssessIndex> existing = assessIndexService.list(wrapper);

        // 计算当前总权重 + 新指标权重
        BigDecimal total = BigDecimal.ZERO;
        for (AssessIndex idx : existing) {
            total = total.add(idx.getWeight());
        }
        total = total.add(assessIndex.getWeight());

        if (total.compareTo(new BigDecimal("100")) > 0) {
            return Result.error("所有指标权重之和不能超过100分，当前已有 " +
                    total.subtract(assessIndex.getWeight()) + " 分");
        }

        assessIndex.setCreatedAt(LocalDateTime.now());
        assessIndexService.save(assessIndex);
        return Result.success("添加成功，当前总权重：" + total + " 分");
    }

    // ==================== 改动③ 清除缓存 ====================
    @CacheEvict(value = "assessIndex", allEntries = true)
    @PutMapping("/update")
    public Result<String> update(@RequestBody AssessIndex assessIndex) {
        // 1. 查询原记录
        AssessIndex old = assessIndexService.getById(assessIndex.getId());
        if (old == null) {
            return Result.error("指标不存在");
        }

        // 2. 校验权重
        if (assessIndex.getWeight() == null || assessIndex.getWeight().compareTo(BigDecimal.ZERO) <= 0) {
            return Result.error("权重必须大于0");
        }

        // 3. 计算除当前指标外的其他指标总权重
        QueryWrapper<AssessIndex> wrapper = new QueryWrapper<>();
        wrapper.eq("status", 1)
                .ne("id", assessIndex.getId());
        List<AssessIndex> others = assessIndexService.list(wrapper);

        BigDecimal otherTotal = BigDecimal.ZERO;
        for (AssessIndex idx : others) {
            otherTotal = otherTotal.add(idx.getWeight());
        }

        // 4. 修改后总权重不能超过100
        BigDecimal newTotal = otherTotal.add(assessIndex.getWeight());
        if (newTotal.compareTo(new BigDecimal("100")) > 0) {
            return Result.error("所有指标权重之和不能超过100分，其他指标合计已占 " + otherTotal + " 分");
        }

        // 5. 更新
        assessIndexService.updateById(assessIndex);
        return Result.success("修改成功，当前总权重：" + newTotal + " 分");
    }

    // ==================== 改动④ 清除缓存 ====================
    @CacheEvict(value = "assessIndex", allEntries = true)
    @DeleteMapping("/{id}")
    public Result<String> delete(@PathVariable Long id) {
        assessIndexService.removeById(id);
        return Result.success("删除成功");
    }
}