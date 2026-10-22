package com.platform.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.platform.common.Result;
import com.platform.entity.MunicipalProject;
import com.platform.service.MunicipalProjectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/project")
@CrossOrigin
public class MunicipalProjectController {

    @Autowired
    private MunicipalProjectService projectService;

    /**
     * 查询所有项目
     */
    @GetMapping("/list")
    public Result<List<MunicipalProject>> list(
            @RequestParam(required = false) String name,
            @RequestParam(required = false) String area,
            @RequestParam(required = false) String providerId,
            @RequestParam(required = false) Integer status) {

        QueryWrapper<MunicipalProject> wrapper = new QueryWrapper<>();

        if (name != null && !name.isEmpty()) {
            wrapper.like("project_name", name);
        }
        if (area != null && !area.isEmpty()) {
            wrapper.eq("project_type", area);
        }
        if (providerId != null && !providerId.isEmpty()) {
            wrapper.eq("provider_id", providerId);
        }
        if (status != null) {
            wrapper.eq("status", status);
        }

        List<MunicipalProject> projects = projectService.listWithStatus(wrapper);
        return Result.success(projects);
    }
    /**
     * 新增项目
     */
    @PostMapping("/add")
    public Result<String> add(@RequestBody MunicipalProject project) {
        try {
            System.out.println("接收到的新增数据: " + project);
            projectService.save(project);
            return Result.success("添加成功");
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("添加失败，详情请查看IDEA控制台: " + e.getMessage());
        }
    }

    /**
     * 【新增这里】修改项目信息
     */
    @PutMapping("/update")
    public Result<String> update(@RequestBody MunicipalProject project) {
        try {
            // MyBatis-Plus 自带的 updateById 方法
            projectService.updateById(project);
            return Result.success("修改成功");
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("修改失败，详情请查看IDEA控制台: " + e.getMessage());
        }
    }

    /**
     * 删除项目
     */
    @DeleteMapping("/{id}")
    public Result<String> delete(@PathVariable Long id) {
        projectService.removeById(id);
        return Result.success("删除成功");
    }
}