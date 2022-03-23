#!/bin/bash

#主機
Host=localhost
#使用者
User=root
#密碼
Pass=1qazxcDE#
#資料庫
DB=employees
#備份路徑 記得開啟寫入權限
backup_path=/tmp/mysql/backup/
#拿日期當部份檔名 方便日後識別
date=$(date +%Y%m%d)
#sql檔案名稱 記得變數前都要加上 $
sqlname=$DB$date.sql
#測試時讓你看是否已經在執行備份
echo “mysqldump…”
#備份語法 將上面的參數 帶入
mysqldump -h $Host -u $User -p$Pass $DB > $backup_path$sqlname
#輸出sql檔案名稱 表示備份完成
echo $sqlname ok!!!
find $backup_path -mtime +10 |xargs rm -rf
echo kill backup ok!!