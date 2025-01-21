#!/bin/bash

# 전역 환경변수 설정: /etc/profile.d/kakao_env.sh 파일을 생성하여 모든 셸과 서비스에서 읽을 수 있도록 함
logger "[INFO] Setting up global environment variables in /etc/profile.d/kakao_env.sh..."
sudo tee /etc/profile.d/kakao_env.sh > /dev/null <<'EOF'
export MYSQL_HOST="{MySQL 엔드포인트}"
export DOMAIN_ID="{조직 ID}"
export PROJECT_ID="{프로젝트 ID}"
export TOPIC_NAME="{topic 이름}"
export CREDENTIAL_ID="{액세스 키 ID}"
export CREDENTIAL_SECRET="{보안 액세스 키}"
EOF

sudo chmod +x /etc/profile.d/kakao_env.sh
logger "[INFO] Global environment variables set. They will be applied for all users and system services."

# 다운로드 받은 스크립트(main_script.sh)는 이 환경변수들을 자동으로 읽을 수 있음
logger "[INFO] Downloading the main script from GitHub..."
curl -sSL -o /tmp/main_script.sh "https://github.com/lys0611/data_analysis_curriculum/raw/refs/heads/main/as_vm/main_script.sh"

if [ -f /tmp/main_script.sh ]; then
  chmod +x /tmp/main_script.sh
  logger "[INFO] main_script.sh downloaded and made executable."

  # 선택 사항: 만약 main_script.sh에서 MYSQL_HOST를 하드코딩하고 있다면, sed로 치환해서 환경변수를 반영
  # (이미 /etc/profile.d/에 지정했으므로, main_script.sh 내에서 export MYSQL_HOST=... 부분이 있다면 아래 치환으로 덮어쓸 수 있음)
  DESIRED_MYSQL_HOST="{MySQL 엔드포인트}"
  logger "[INFO] Overriding MYSQL_HOST in main_script.sh with: $DESIRED_MYSQL_HOST"
  sed -i "s|^export MYSQL_HOST=.*|export MYSQL_HOST=\"$DESIRED_MYSQL_HOST\"|" /tmp/main_script.sh

  logger "[INFO] Running main_script.sh now..."
  /tmp/main_script.sh
  logger "[INFO] main_script.sh run completed."
else
  logger "[ERROR] Failed to download main_script.sh from GitHub."
  exit 1
fi
