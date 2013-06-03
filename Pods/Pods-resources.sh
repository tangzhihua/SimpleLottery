#!/bin/sh

install_resource()
{
  case $1 in
    *.storyboard)
      echo "ibtool --reference-external-strings-file --errors --warnings --notices --output-format human-readable-text --compile ${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .storyboard`.storyboardc ${PODS_ROOT}/$1 --sdk ${SDKROOT}"
      ibtool --reference-external-strings-file --errors --warnings --notices --output-format human-readable-text --compile "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .storyboard`.storyboardc" "${PODS_ROOT}/$1" --sdk "${SDKROOT}"
      ;;
    *.xib)
        echo "ibtool --reference-external-strings-file --errors --warnings --notices --output-format human-readable-text --compile ${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .xib`.nib ${PODS_ROOT}/$1 --sdk ${SDKROOT}"
      ibtool --reference-external-strings-file --errors --warnings --notices --output-format human-readable-text --compile "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .xib`.nib" "${PODS_ROOT}/$1" --sdk "${SDKROOT}"
      ;;
    *.framework)
      echo "rsync -rp ${PODS_ROOT}/$1 ${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      rsync -rp "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      ;;
    *.xcdatamodeld)
      echo "xcrun momc ${PODS_ROOT}/$1 ${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename $1 .xcdatamodeld`.momd"
      xcrun momc "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename $1 .xcdatamodeld`.momd"
      ;;
    *)
      echo "rsync -av --exclude '*/.svn/*' ${PODS_ROOT}/$1 ${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
      rsync -av --exclude '*/.svn/*' "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
      ;;
  esac
}
install_resource 'DLStarRating/DLStarRating/images/star.png'
install_resource 'DLStarRating/DLStarRating/images/star@2x.png'
install_resource 'DLStarRating/DLStarRating/images/star_highlighted-darker.png'
install_resource 'DLStarRating/DLStarRating/images/star_highlighted-darker@2x.png'
install_resource 'DLStarRating/DLStarRating/images/star_highlighted.png'
install_resource 'DLStarRating/DLStarRating/images/star_highlighted@2x.png'
install_resource 'EGOTableViewPullRefresh/EGOTableViewPullRefresh/Resources/blackArrow.png'
install_resource 'EGOTableViewPullRefresh/EGOTableViewPullRefresh/Resources/blackArrow@2x.png'
install_resource 'EGOTableViewPullRefresh/EGOTableViewPullRefresh/Resources/blueArrow.png'
install_resource 'EGOTableViewPullRefresh/EGOTableViewPullRefresh/Resources/blueArrow@2x.png'
install_resource 'EGOTableViewPullRefresh/EGOTableViewPullRefresh/Resources/grayArrow.png'
install_resource 'EGOTableViewPullRefresh/EGOTableViewPullRefresh/Resources/grayArrow@2x.png'
install_resource 'EGOTableViewPullRefresh/EGOTableViewPullRefresh/Resources/whiteArrow.png'
install_resource 'EGOTableViewPullRefresh/EGOTableViewPullRefresh/Resources/whiteArrow@2x.png'
install_resource 'QuadCurveMenu/AwesomeMenu/Images/bg-addbutton-highlighted.png'
install_resource 'QuadCurveMenu/AwesomeMenu/Images/bg-addbutton-highlighted@2x.png'
install_resource 'QuadCurveMenu/AwesomeMenu/Images/bg-addbutton.png'
install_resource 'QuadCurveMenu/AwesomeMenu/Images/bg-addbutton@2x.png'
install_resource 'QuadCurveMenu/AwesomeMenu/Images/bg-menuitem-highlighted.png'
install_resource 'QuadCurveMenu/AwesomeMenu/Images/bg-menuitem-highlighted@2x.png'
install_resource 'QuadCurveMenu/AwesomeMenu/Images/bg-menuitem.png'
install_resource 'QuadCurveMenu/AwesomeMenu/Images/bg-menuitem@2x.png'
install_resource 'QuadCurveMenu/AwesomeMenu/Images/icon-plus-highlighted.png'
install_resource 'QuadCurveMenu/AwesomeMenu/Images/icon-plus-highlighted@2x.png'
install_resource 'QuadCurveMenu/AwesomeMenu/Images/icon-plus.png'
install_resource 'QuadCurveMenu/AwesomeMenu/Images/icon-plus@2x.png'
install_resource 'QuadCurveMenu/AwesomeMenu/Images/icon-star.png'
install_resource 'QuadCurveMenu/AwesomeMenu/Images/icon-star@2x.png'
install_resource 'SVProgressHUD/SVProgressHUD/SVProgressHUD.bundle'
