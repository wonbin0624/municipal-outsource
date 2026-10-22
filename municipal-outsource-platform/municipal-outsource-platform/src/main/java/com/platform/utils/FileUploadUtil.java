package com.platform.utils;

import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

public class FileUploadUtil {

    // 文件上传根目录（根据实际情况调整）
    private static final String BASE_PATH = "D:/municipal-outsource/uploads/";

    /**
     * 上传文件
     * @param file 上传的文件
     * @param module 模块名称（如：license、patrol、rectify）
     * @return 文件访问路径
     */
    public static String uploadFile(MultipartFile file, String module) throws IOException {
        // 1. 校验文件是否为空
        if (file == null || file.isEmpty()) {
            throw new RuntimeException("文件不能为空");
        }

        // 2. 获取原文件名
        String originalFilename = file.getOriginalFilename();
        if (originalFilename == null) {
            throw new RuntimeException("文件名无效");
        }

        // 3. 生成新文件名（UUID + 时间戳 + 原后缀）
        String ext = originalFilename.substring(originalFilename.lastIndexOf("."));
        String newFileName = UUID.randomUUID().toString().replace("-", "") +
                new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()) + ext;

        // 4. 创建存储目录（按模块和日期分类）
        String datePath = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        String uploadPath = BASE_PATH + module + "/" + datePath + "/";
        File dir = new File(uploadPath);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        // 5. 保存文件
        File dest = new File(uploadPath + newFileName);
        file.transferTo(dest);

        // 6. 返回访问路径（相对路径）
        return "/uploads/" + module + "/" + datePath + "/" + newFileName;
    }

    /**
     * 删除文件
     * @param filePath 文件路径
     * @return 是否删除成功
     */
    public static boolean deleteFile(String filePath) {
        if (filePath == null || filePath.isEmpty()) {
            return false;
        }
        File file = new File(BASE_PATH + filePath.replace("/uploads/", ""));
        if (file.exists()) {
            return file.delete();
        }
        return false;
    }
}