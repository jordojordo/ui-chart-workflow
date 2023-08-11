GITHUB_RELEASE_TAG=$1
GITHUB_RUN_ID=$2
GITHUB_WORKFLOW_TYPE=$3

# Check packages for released tag name
if [[ "${GITHUB_WORKFLOW_TYPE}" == "container" ]]; then
  for d in pkg/*/ ; do
    pkg=$(basename $d)

    PKG_VERSION=$(jq -r .version pkg/${pkg}/package.json)
    PKG_NAME="${pkg}-${PKG_VERSION}"

    if [[ "${GITHUB_RELEASE_TAG}" == "${PKG_NAME}" ]]; then
      gh run cancel ${GITHUB_RUN_ID}
    else
      continue
    fi
  done
else
  # Check base extension name for tag name
  BASE_EXT=$(jq -r .name package.json)
  EXT_VERSION=$(jq -r .version package.json)

  if [[ "${GITHUB_RELEASE_TAG}" == "${BASE_EXT}-${EXT_VERSION}" ]]; then
    echo -e "tag: ${GITHUB_RELEASE_TAG}"
    gh run cancel ${GITHUB_RUN_ID}
  fi
fi