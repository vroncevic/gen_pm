#!/bin/bash
#
# @brief   Generating Perl module
# @version ver.1.0
# @date    Wed May 11 13:00:19 CEST 2016
# @company Frobas IT Department, www.frobas.com 2016
# @author  Vladimir Roncevic <vladimir.roncevic@frobas.com>
#
UTIL_ROOT=/root/scripts
UTIL_VERSION=ver.1.0
UTIL=$UTIL_ROOT/sh-util-srv/$UTIL_VERSION
UTIL_LOG=$UTIL/log

. $UTIL/bin/checkroot.sh
. $UTIL/bin/checktool.sh
. $UTIL/bin/loadutilconf.sh
. $UTIL/bin/loadconf.sh
. $UTIL/bin/usage.sh
. $UTIL/bin/devel.sh

GENPM_TOOL=genpm
GENPM_VERSION=ver.1.0
GENPM_HOME=$UTIL_ROOT/$GENPM_TOOL/$GENPM_VERSION
GENPM_CFG=$GENPM_HOME/conf/$GENPM_TOOL.cfg
GENPM_UTIL_CFG=$GENPM_HOME/conf/${GENPM_TOOL}_util.cfg
GENPM_LOG=$GENPM_HOME/log

declare -A GENPM_USAGE=(
	[TOOL_NAME]="__$GENPM_TOOL"
	[ARG1]="[MODULE_NAME] Name of Perl module (file name)"
	[EX-PRE]="# Create FileCheck module"
	[EX]="__$GENPM_TOOL FileCheck"
)

TOOL_DBG="false"

#
# @brief   Main function 
# @params  Values required name of Perl module and option
# @exitval Function genpm exit with integer value
#			0   - success operation 
# 			127 - run as root user
#			128 - missing argument
#			129 - missing main config file
#			130 - missing util config file
#			131 - missing h2xs tool
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
		local MSG=""
		declare -A cfggenpm=()
		__loadconf $GENPM_CFG cfggenpm
		local STATUS=$?
		if [ "$STATUS" -eq "$NOT_SUCCESS" ]; then
			exit 129
		fi
		declare -A cfggenpmutil=()
		__loadutilconf $GENPM_UTIL_CFG cfggenpmutil
		STATUS=$?
		if [ "$STATUS" -eq "$NOT_SUCCESS" ]; then
			exit 130
		fi
		__checktool "${cfggenpmutil[H2XS]}"
		STATUS=$?
		if [ "$STATUS" -eq "$SUCCESS" ]; then
			local DATE=$(date)
			MSG="Generating module [$MODULE_NAME]"
			if [ "$TOOL_DBG" == "true" ]; then
				printf "$DSTA" "$GENPM_TOOL" "$FUNC" "$MSG"
			else
				printf "$SEND" "[$GENPM_TOOL]" "$MSG"
			fi
			if [ -n "$WITH_C_CODE" ]; then
				if [ "$WITH_C_CODE" == "wc" ]; then
					eval "${cfggenpmutil[H2XS]} -cn \"$MODULE_NAME\""
				fi
				:
			else
				eval "${cfggenpmutil[H2XS]} -AX -n \"$MODULE_NAME\""
			fi
			MSG="Set owner $UGID \"$MODULE_NAME\""
			if [ "$TOOL_DBG" == "true" ]; then
				printf "$DSTA" "$GENPM_TOOL" "$FUNC" "$MSG"
			else
				printf "$SEND" "[$GENPM_TOOL]" "$MSG"
			fi
			chown -R ${cfggenpmutil[UGID]} "$MODULE_NAME/"
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
				printf "$SEND" "[$GENPM_TOOL]" "$MSG"
			fi
			exit 0
		fi
		exit 131
	fi
	__usage $GENPM_USAGE
	exit 128
}

#
# @brief   Main entry point
# @params  Values required module name and option with C code
# @exitval Script tool genpm exit with integer value
#			0   - success operation 
# 			127 - run as root user
#			128 - missing argument
#			129 - missing main config file
#			130 - missing util config file
#			131 - missing h2xs tool
#
printf "\n%s\n%s\n\n" "$GENPM_TOOL $GENPM_VERSION" "`date`"
__checkroot
STATUS=$?
if [ "$STATUS" -eq "$SUCCESS" ]; then
	__genpm "$1" "$2"
fi

exit 127
