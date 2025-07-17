#!/usr/bin/env zsh

# —— 脚本设置 —— #
set -euo pipefail

# —— 1. 检查 conda —— #
if ! command -v conda >/dev/null 2>&1; then
  echo "Error: conda 命令未找到，请先安装 Anaconda/Miniconda。" >&2
  exit 1
fi

# —— 2. 初始化 conda —— #
# 这里假设你的 conda 基路径在 $(conda info --base)
# 这样才能在非交互 shell 中使用 conda activate
CONDA_BASE=$(conda info --base)
if [ -f "${CONDA_BASE}/etc/profile.d/conda.sh" ]; then
  # 推荐方式：source conda.sh
  source "${CONDA_BASE}/etc/profile.d/conda.sh"
elif [ -f "${HOME}/.zshrc" ]; then
  # 备用：source 用户的 zsh 配置，让其中的 conda 初始化生效
  source "${HOME}/.zshrc"
else
  echo "Warning: 找不到 conda 初始化脚本，'conda activate' 可能失败。" >&2
fi

# —— 3. 激活环境 —— #
echo "Activating conda environment: px4"
conda activate px4

# —— 4. 编译 PX4 SITL —— #
echo "Building PX4 SITL..."
make px4_sitl_default

echo "Done."