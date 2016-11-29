#!/bin/bash
#
# @brief   Generating Perl Package Module
# @version ver.1.0
# @date    Wed May 11 13:00:19 CEST 2016
# @company Frobas IT Department, www.frobas.com 2016
# @author  Vladimir Roncevic <vladimir.roncevic@frobas.com>
#
UTIL_ROOT=/root/scripts
UTIL_VERSION=ver.1.0
UTIL=$UTIL_ROOT/sh-util-srv/$UTIL_VERSION
UTIL_LOG=$UTIL/log

. $UTIL/bin/devel.sh
. $UTIL/bin/usage.sh
. $UTIL/bin/checkroot.sh
. $UTIL/bin/checktool.sh
. $UTIL/bin/logging.sh
. $UTIL/bin/sendmail.sh
. $UTIL/bin/loadconf.sh
. $UTIL/bin/loadutilconf.sh
. $UTIL/bin/progressbar.sh

GENPM_TOOL=genpm
GENPM_VERSION=ver.1.0
GENPM_HOME=$UTIL_ROOT/$GENPM_TOOL/$GENPM_VERSION
GENPM_CFG=$GENPM_HOME/conf/$GENPM_TOOL.cfg
GENPM_UTIL_CFG=$GENPM_HOME/conf/${GENPM_TOOL}_util.cfg
GENPM_LOG=$GENPM_HOME/log

declare -A GENPM_USAGE=(
	[USAGE_TOOL]="__$GENPM_TOOL"
	[USAGE_ARG1]="[MODULE_NAME] Name of Perl module (file name)"
	[USAGE_EX_PRE]="# Create FileCheck module"
	[USAGE_EX]="__$GENPM_TOOL FileCheck"
)

declare -A GENPM_LOG=(
	[LOG_TOOL]="$GENPM_TOOL"
	[LOG_FLAG]="info"
	[LOG_PATH]="$GENPM_LOG"
	[LOG_MSGE]="None"
)

declare -A PB_STRUCTURE=(
	[BAR_WIDTH]=50
	[MAX_PERCENT]=100
	[SLEEP]=0.01
)

TOOL_DBG="false"

#
# @brief   Main function 
# @params  Values required name of Perl module and option
# @exitval Function __genpm exit with integer value
#			0   - tool finished with success operation
#			128 - missing argument(s) from cli 
#			129 - failed to load tool script configuration from file
#			130 - failed to load tool script utilities configuration from file
#			131 - missing external tool h2xs
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# MODULE_NAME="FileCheck"
# __genpm "$MODULE_NAME"
#
function __genpm() {
	local MODULE_NAME=$1
	local WITH_C_CODE=$2
	if [ -n "$MODULE_NAME" ]; then
		local FUNC=${FUNCNAME[0]}
		local MSG="Loading basic and util configuration"
		printf "$SEND" "$OSSL_TOOL" "$MSG"
		__progressbar PB_STRUCTURE
		printf "%s\n\n" ""
		declare -A configgenpm=()
		__loadconf $GENPM_CFG configgenpm
		local STATUS=$?
		if [ $STATUS -eq $NOT_SUCCESS ]; then
			MSG="Failed to load tool script configuration"
			if [ "$TOOL_DBG" == "true" ]; then
				printf "$DSTA" "$GENPM_TOOL" "$FUNC" "$MSG"
			else
				printf "$SEND" "$GENPM_TOOL" "$MSG"
			fi
			exit 129
		fi
		declare -A configgenpmutil=()
		__loadutilconf $GENPM_UTIL_CFG configgenpmutil
		STATUS=$?
		if [ $STATUS -eq $NOT_SUCCESS ]; then
			MSG="Failed to load tool script utilities configuration"
			if [ "$TOOL_DBG" == "true" ]; then
				printf "$DSTA" "$GENPM_TOOL" "$FUNC" "$MSG"
			else
				printf "$SEND" "$GENPM_TOOL" "$MSG"
			fi
			exit 130
		fi
		__checktool "${configgenpmutil[H2XS]}"
		STATUS=$?
		if [ $STATUS -eq $SUCCESS ]; then
			local DATE=$(date)
			MSG="Generating module [$MODULE_NAME]"
			if [ "$TOOL_DBG" == "true" ]; then
				printf "$DSTA" "$GENPM_TOOL" "$FUNC" "$MSG"
			else
				printf "$SEND" "$GENPM_TOOL" "$MSG"
			fi
			if [ "${configgenpm[LOGGING]}" == "true" ]; then
				GENPM_LOG[LOG_MSGE]=$MSG
				GENPM_LOG[LOG_FLAG]="info"
				__logging GENPM_LOG
			fi
			if [ -n "$WITH_C_CODE" ]; then
				if [ "$WITH_C_CODE" == "wc" ]; then
					eval "${configgenpmutil[H2XS]} -cn \"$MODULE_NAME\""
				fi
				:
			else
				eval "${configgenpmutil[H2XS]} -AX -n \"$MODULE_NAME\""
			fi
			MSG="Set owner $UGID \"$MODULE_NAME\""
			if [ "$TOOL_DBG" == "true" ]; then
				printf "$DSTA" "$GENPM_TOOL" "$FUNC" "$MSG"
			else
				printf "$SEND" "$GENPM_TOOL" "$MSG"
			fi
			local PRFX_CMD="chown -R"
			local OWNER=${configgenpmutil[UGID]} 
			eval "$PRFX_CMD $OWNER $MODULE_NAME/"
			MSG="Set permission \"$MODULE_NAME\""
			if [ "$TOOL_DBG" == "true" ]; then
				printf "$DSTA" "$GENPM_TOOL" "$FUNC" "$MSG"
			else
				printf "$SEND" "[$GENPM_TOOL]" "$MSG"
			fi
			chmod -R 700 "$MODULE_NAME/"
			MSG="Done"
			if [ "$TOOL_DBG" == "true" ]; then
				printf "$DSTA" "$GENPM_TOOL" "$FUNC" "$MSG"
			else
				printf "$SEND" "$GENPM_TOOL" "$MSG"
			fi
			if [ "${configgenpm[LOGGING]}" == "true" ]; then
				GENPM_LOG[LOG_MSGE]=$MSG
				GENPM_LOG[LOG_FLAG]="info"
				__logging GENPM_LOG
			fi
			exit 0
		fi
		MSG="Missing external tool ${configgenpmutil[H2XS]}"
		if [ "$TOOL_DBG" == "true" ]; then
			printf "$DSTA" "$GENPM_TOOL" "$FUNC" "$MSG"
		else
			printf "$SEND" "$GENPM_TOOL" "$MSG"
		fi
		if [ "${configgenpm[LOGGING]}" == "true" ]; then
			GENPM_LOG[LOG_MSGE]=$MSG
			GENPM_LOG[LOG_FLAG]="info"
			__logging GENPM_LOG
		fi
		if [ "${configgenpm[EMAILING]}" == "true" ]; then
			__sendmail "$MSG" "${configgenpm[ADMIN_EMAIL]}"
		fi
		exit 131
	fi
	__usage GENPM_USAGE
	exit 128
}

#
# @brief   Main entry point
# @params  Values required module name and option with C code
# @exitval Script tool genpm exit with integer value
#			0   - tool finished with success operation
# 			127 - run tool script as root user from cli
#			128 - missing argument(s) from cli 
#			129 - failed to load tool script configuration from file
#			130 - failed to load tool script utilities configuration from file
#			131 - missing external tool h2xs
#
printf "\n%s\n%s\n\n" "$GENPM_TOOL $GENPM_VERSION" "`date`"
__checkroot
STATUS=$?
if [ "$STATUS" -eq "$SUCCESS" ]; then
	__genpm "$1" "$2"
fi

exit 127

