package com.platform.controller;

import com.platform.common.Result;
import com.platform.utils.FileUploadUtil;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/file")
@CrossOrigin
public class FileController {

    /**
     * 通用文件上传接口
     * @param file 上传的文件
     * @param module 模块名称：license(资质)、patrol(巡检)、rectify(整改)
     * @return 文件访问路径
     */
    @PostMapping("/upload")
    public Result<Map<String, String>> uploadFile(
            @RequestParam("file") MultipartFile file,
            @RequestParam(value = "module", defaultValue = "common") String module) {

        try {
            // 校验文件类型（只允许图片和PDF）
            String contentType = file.getContentType();
            if (contentType == null ||
                    (!contentType.startsWith("image/") && !"application/pdf".equals(contentType))) {
                return Result.error("只支持图片和PDF文件");
            }

            // 校验文件大小（10MB）
            if (file.getSize() > 10 * 1024 * 1024) {
                return Result.error("文件大小不能超过10MB");
            }

            // 上传文件
            String filePath = FileUploadUtil.uploadFile(file, module);

            // 返回文件路径
            Map<String, String> data = new HashMap<>();
            data.put("filePath", filePath);
            data.put("fileName", file.getOriginalFilename());
            data.put("fileSize", String.valueOf(file.getSize()));

            return Result.success(data);
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("文件上传失败：" + e.getMessage());
        }
    }

    /**
     * 删除文件
     * @param filePath 文件路径
     * @return 是否删除成功
     */
    @DeleteMapping("/delete")
    public Result<String> deleteFile(@RequestParam String filePath) {
        boolean success = FileUploadUtil.deleteFile(filePath);
        if (success) {
            return Result.success("文件删除成功");
        } else {
            return Result.error("文件删除失败");
        }
    }
}