#!/bin/bash
#
# @brief   Generating Perl Package Module
# @version ver.2.0
# @date    Sun 05 Dec 2021 04:45:55 AM CET
# @company None, free software to use 2021
# @author  Vladimir Roncevic <elektron.ronca@gmail.com>
#
UTIL_ROOT=/root/scripts
UTIL_VERSION=ver.1.0
UTIL=${UTIL_ROOT}/sh_util/${UTIL_VERSION}
UTIL_LOG=${UTIL}/log

.    ${UTIL}/bin/devel.sh
.    ${UTIL}/bin/usage.sh
.    ${UTIL}/bin/check_root.sh
.    ${UTIL}/bin/check_tool.sh
.    ${UTIL}/bin/logging.sh
.    ${UTIL}/bin/send_mail.sh
.    ${UTIL}/bin/load_conf.sh
.    ${UTIL}/bin/load_util_conf.sh
.    ${UTIL}/bin/progress_bar.sh

GEN_PM_TOOL=gen_pm
GEN_PM_VERSION=ver.2.0
GEN_PM_HOME=${UTIL_ROOT}/${GEN_PM_TOOL}/${GEN_PM_VERSION}
GEN_PM_CFG=${GEN_PM_HOME}/conf/${GEN_PM_TOOL}.cfg
GEN_PM_UTIL_CFG=${GEN_PM_HOME}/conf/${GEN_PM_TOOL}_util.cfg
GEN_PM_LOGO=${GEN_PM_HOME}/conf/${GEN_PM_TOOL}.logo
GEN_PM_LOG=${GEN_PM_HOME}/log

tabs 4
CONSOLE_WIDTH=$(stty size | awk '{print $2}')

.    ${GEN_PM_HOME}/bin/center.sh
.    ${GEN_PM_HOME}/bin/display_logo.sh

declare -A GEN_PM_USAGE=(
    [USAGE_TOOL]="${GEN_PM_TOOL}"
    [USAGE_ARG1]="[MODULE NAME] Name of Perl Module (file name)"
    [USAGE_ARG2]="[WITH_C_CODE] Flag for generating C code (optional)"
    [USAGE_EX_PRE]="# Create FileCheck module"
    [USAGE_EX]="${GEN_PM_TOOL} FileCheck"
)

declare -A GEN_PM_LOGGING=(
    [LOG_TOOL]="${GEN_PM_TOOL}"
    [LOG_FLAG]="info"
    [LOG_PATH]="${GEN_PM_LOG}"
    [LOG_MSGE]="None"
)

declare -A PB_STRUCTURE=(
    [BW]=50
    [MP]=100
    [SLEEP]=0.01
)

TOOL_DBG="false"
TOOL_LOG="true"
TOOL_NOTIFY="false"

#
# @brief   Main function 
# @params  Values required name of Perl module and option
# @exitval Function __gen_pm exit with integer value
#            0   - tool finished with success operation
#            128 - missing argument(s) from cli
#            129 - failed to load tool script configuration from files
#            130 - missing external tool h2xs
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# MNAME="FileCheck"
# __gen_pm "$MNAME"
#
function __gen_pm {
    local MNAME=$1 WCCODE=$2
    display_logo
    if [ -n "${MNAME}" ]; then
        local FUNC=${FUNCNAME[0]} MSG="None"
        local STATUS_CONF STATUS_CONF_UTIL STATUS
        MSG="Loading basic and util configuration!"
        info_debug_message "$MSG" "$FUNC" "$GEN_PM_TOOL"
        progress_bar PB_STRUCTURE
        declare -A config_gen_pm=()
        load_conf "$GEN_PM_CFG" config_gen_pm
        STATUS_CONF=$?
        declare -A config_gen_pm_util=()
        load_util_conf "$GEN_PM_UTIL_CFG" config_gen_pm_util
        STATUS_CONF_UTIL=$?
        declare -A STATUS_STRUCTURE=(
            [1]=$STATUS_CONF [2]=$STATUS_CONF_UTIL
        )
        check_status STATUS_STRUCTURE
        STATUS=$?
        if [ $STATUS -eq $NOT_SUCCESS ]; then
            MSG="Force exit!"
            info_debug_message_end "$MSG" "$FUNC" "$GEN_PM_TOOL"
            exit 129
        fi
        TOOL_LOG=${config_gen_pm[LOGGING]}
        TOOL_DBG=${config_gen_pm[DEBUGGING]}
        TOOL_NOTIFY=${config_gen_pm[EMAILING]}
        local H2XS=${config_gen_pm_util[H2XS]}
        check_tool "${H2XS}"
        STATUS=$?
        if [ $STATUS -eq $SUCCESS ]; then
            local DATE=$(date) TREE
            MSG="Generating module [${MNAME}]"
            info_debug_message "$MSG" "$FUNC" "$GEN_PM_TOOL"
            if [[ -n "${WCCODE}" && "${WCCODE}" == "wc" ]]; then
                eval "${H2XS} -cn \"${MNAME}\""
            else
                eval "${H2XS} -AX -n \"${MNAME}\""
            fi
            local USRID=${config_gen_pm_util[USERID]}
            local GRPID=${config_gen_pm_util[GROUPID]}
            MSG="Set owner!"
            info_debug_message "$MSG" "$FUNC" "$GEN_PM_TOOL"
            eval "chown -R ${USRID}.${GRPID} ${MNAME}/"
            MSG="Set permission!"
            info_debug_message "$MSG" "$FUNC" "$GEN_PM_TOOL"
            eval "chmod -R 700 ${MNAME}/"
            info_debug_message_end "Done" "$FUNC" "$GEN_PM_TOOL"
            MSG="Generated module ${MNAME}"
            GEN_PM_LOGGING[LOG_MSGE]="$MSG"
            GEN_PM_LOGGING[LOG_FLAG]="info"
            logging GEN_PM_LOGGING
            TREE=$(which tree)
            check_tool "${TREE}"
            STATUS=$?
            if [ $STATUS -eq $SUCCESS ]; then
                eval "${TREE} -L 3 ${MNAME}/"
            fi
            exit 0
        fi
        GEN_PM_LOG[LOG_MSGE]="Missing tool ${H2XS}"
        GEN_PM_LOG[LOG_FLAG]="info"
        logging GEN_PM_LOG
        send_mail "$MSG" "${config_gen_pm[ADMIN_EMAIL]}"
        MSG="Force exit!"
        info_debug_message_end "$MSG" "$FUNC" "$GEN_PM_TOOL"
        exit 130
    fi
    usage GEN_PM_USAGE
    exit 128
}

#
# @brief   Main entry point
# @params  Values required module name and option with C code
# @exitval Script tool gen_pm exit with integer value
#            0   - tool finished with success operation
#            127 - run tool script as root user from cli
#            128 - missing argument(s) from cli 
#            129 - failed to load tool script configuration from files
#            130 - missing external tool h2xs
#
printf "\n%s\n%s\n\n" "${GEN_PM_TOOL} ${GEN_PM_VERSION}" "`date`"
check_root
STATUS=$?
if [ $STATUS -eq $SUCCESS ]; then
    __gen_pm $1 $2
fi

exit 127
