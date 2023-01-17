execute_process(COMMAND "/home/lxf/lxf_work/learning_mpac/mpac_control/build/mpac/mpac_teleop/catkin_generated/python_distutils_install.sh" RESULT_VARIABLE res)

if(NOT res EQUAL 0)
  message(FATAL_ERROR "execute_process(/home/lxf/lxf_work/learning_mpac/mpac_control/build/mpac/mpac_teleop/catkin_generated/python_distutils_install.sh) returned error code ")
endif()
