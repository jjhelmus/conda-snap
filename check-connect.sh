#! /bin/bash -e
# Check that the conda-user-dir interface is connected

DOT_CONDA_DIR="${HOME}/.conda"
mkdir -p "${DOT_CONDA_DIR}"

TEST_FILE="${DOT_CONDA_DIR}/.snap_check_file"

SHOW_MESSAGE="n"
rm -f "${TEST_FILE}" &> /dev/null || true
if [[  -e "${TEST_FILE}" ]] ; then
    SHOW_MESSAGE="y"
fi

touch "${TEST_FILE}" &> /dev/null || true
if ! [[  -e "${TEST_FILE}" ]] ; then
    SHOW_MESSAGE="y"
fi

if [[ $SHOW_MESSAGE == "y" ]] ; then
    echo -e "\e[7mThe conda installed via snap cannot write to the .conda directory\e[0m"
    echo -e "\e[7mtypically this can be fixed by running:\e[0m"
    echo -e "    \e[7msudo snap connect conda:conda-user-dir\e[0m"
    echo -e ""
    echo -e "\e[7malternatively run the command:\e[0m"
    echo -e "    \e[7msource /snap/conda/current/etc/profile.d/conda.sh\e[0m"
    echo -e ""
fi

exec "$@"
