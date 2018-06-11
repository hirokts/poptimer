#!/bin/bash -ue

INTERVAL=300
I_SECONDS=0
I_MINUTES=0
PROGNAME=$(basename $0)
VERSION="1.0"
HELP_MSG="'$PROGNAME -h'と指定することでヘルプを見ることができます"

usage() {
  echo "Usage: $PROGNAME [-m <minutes>] [-s <seconds>]"
  echo 
  echo "オプション:"
  echo "  -h, --help"
  echo "  -s, --time-seconds <seconds>     [任意] *オプション指定時は秒数を設定"
  echo "  -m, --time-minutes <seconds>     [任意] *オプション指定時は分数を設定"
  echo
  exit 1
}

for OPT in "$@"
do
  case "$OPT" in
    # ヘルプメッセージ
    '-h'|'--help' )
      usage
      exit 1
      ;;
    # 秒数指定
    '-s'|'--time-seconds' )
      # オプションに引数がなかった場合
      if [[ -z "$2" ]] || [[ "$2" =~ ^-+ ]]; then
      echo "$PROGNAME: 「秒数」が指定されていません。'$PROGNAME -h'で確認してください" 1>&2
      exit 1
      else
        # オプションの引数設定
        ARG="$2"
        expr "$ARG" + 1 >/dev/null 2>&1
        if [ $? -lt 2 ]
        then
            INTERVAL=0
            I_SECONDS=$ARG
        else
            echo "$PROGNAME: 「秒数」が指定されていません。'$PROGNAME -h'で確認してください" 1>&2
            exit 1
        fi
        shift 2
      fi
      ;;
    # 分数指定
    '-m'|'--time-minutes' )
      # オプションに引数がなかった場合
      if [[ -z "$2" ]] || [[ "$2" =~ ^-+ ]]; then
          echo "$PROGNAME: 「分数」が指定されていません。'$PROGNAME -h'で確認してください" 1>&2
          exit 1
      else
        # オプションの引数設定
        ARG="$2"
        expr "$ARG" + 1 >/dev/null 2>&1
        if [ $? -lt 2 ]
        then
            INTERVAL=0
            I_MINUTES=$ARG
        else
            echo "$PROGNAME: 「分数」が指定されていません。'$PROGNAME -h'で確認してください" 1>&2
            exit 1
        fi
        shift 2
      fi
      ;;
    -*)
      echo "$PROGNAME: 「$(echo $1 | sed 's/^-*//')」オプションは存在しません。'$PROGNAME -h'で確認してください" 1>&2
      exit 1
      ;;
  esac
done

if [ $INTERVAL -eq 0 ]; then
    INTERVAL=`expr $I_MINUTES \* 60 + $I_SECONDS`
else
    I_MINUTES=5; I_SECONDS=0
fi
(sleep $INTERVAL; notify-send -u low "時間通知" "[$I_MINUTES分$I_SECONDS秒] 経過しました") &
