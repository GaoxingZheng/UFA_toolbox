#!/bin/bash

### AUTHOR : Gaoxing Zheng
### Institution: Zhongshan Hospital, Fudan University
### EMAIL CONTACT: zheng_gao_xing@163.com
### DATE: 2022-04-14

UFA_correct_bval() {
  local file_path="$1"
  
  # 从文件中读取bval变量
  local bval=$(cat "$file_path")

  # 检查bval中的第一个值是否为0
  local first_value=$(echo "$bval" | awk '{print $1}')
  if [[ $first_value != "0" ]]; then
    # 使用awk进行四舍五入
    local rounded=$(echo "$bval" | awk '{for(i=1;i<=NF;i++){printf "%.0f ", ($i)/100}}')
    local result=$(echo "$rounded" | awk '{for(i=1;i<=NF;i++){printf "%.0f ", ($i)*100}}')

    # 将结果覆盖写回文件
    echo "$result" > "$file_path"

    # 打印更新后的bval变量
    echo "Updated bval:"
    cat "$file_path"
  else
    echo "No rounding needed. bval starts with 0."
  fi
}

UFA_correct_bval $1
