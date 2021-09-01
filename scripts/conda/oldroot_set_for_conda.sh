# Source this script to set up the ROOT build that this script is part of.
#
# Conveniently an alias like this can be defined in .bashrc:
#   alias thisroot=". bin/thisroot.sh"
#
# This script if for the bash like shells, see thisroot.csh for csh like shells.
#
# Author: Fons Rademakers, 18/8/2006
#
# Edited for CutLang

drop_from_path()
{
   # Assert that we got enough arguments
   if test $# -ne 2 ; then
      echo "drop_from_path: needs 2 arguments"
      return 1
   fi

   local p=$1
   local drop=$2

   newpath=`echo $p | sed -e "s;:${drop}:;:;g" \
                          -e "s;:${drop}\$;;g"   \
                          -e "s;^${drop}:;;g"   \
                          -e "s;^${drop}\$;;g"`
}

clean_environment()
{

   if [ -n "${CONDA_PREFIX}" ] ; then
      if [ -n "${PATH}" ]; then
         drop_from_path "$PATH" "${CONDA_PREFIX}/bin"
         PATH=$newpath
      fi
      if [ -n "${LD_LIBRARY_PATH}" ]; then
         drop_from_path "$LD_LIBRARY_PATH" "${CONDA_PREFIX}/lib"
         LD_LIBRARY_PATH=$newpath
      fi
      if [ -n "${DYLD_LIBRARY_PATH}" ]; then
         drop_from_path "$DYLD_LIBRARY_PATH" "${CONDA_PREFIX}/lib"
         DYLD_LIBRARY_PATH=$newpath
      fi
      if [ -n "${SHLIB_PATH}" ]; then
         drop_from_path "$SHLIB_PATH" "${CONDA_PREFIX}/lib"
         SHLIB_PATH=$newpath
      fi
      if [ -n "${LIBPATH}" ]; then
         drop_from_path "$LIBPATH" "${CONDA_PREFIX}/lib"
         LIBPATH=$newpath
      fi
      if [ -n "${PYTHONPATH}" ]; then
         drop_from_path "$PYTHONPATH" "${CONDA_PREFIX}/lib"
         PYTHONPATH=$newpath
      fi
      if [ -n "${MANPATH}" ]; then
         drop_from_path "$MANPATH" "${CONDA_PREFIX}/man"
         MANPATH=$newpath
      fi
      if [ -n "${CMAKE_PREFIX_PATH}" ]; then
         drop_from_path "$CMAKE_PREFIX_PATH" "${CONDA_PREFIX}"
         CMAKE_PREFIX_PATH=$newpath
      fi
      if [ -n "${JUPYTER_PATH}" ]; then
         drop_from_path "$JUPYTER_PATH" "${CONDA_PREFIX}/etc/notebook"
         JUPYTER_PATH=$newpath
      fi
      if [ -n "${JUPYTER_CONFIG_DIR}" ]; then
         drop_from_path "$JUPYTER_CONFIG_DIR" "${CONDA_PREFIX}/etc/notebook"
         JUPYTER_CONFIG_DIR=$newpath
      fi
   fi
   if [ -z "${MANPATH}" ]; then
      # Grab the default man path before setting the path to avoid duplicates
      if command -v manpath >/dev/null; then
         default_manpath=`manpath`
      elif command -v man >/dev/null; then
         default_manpath=`man -w 2> /dev/null`
      else
         default_manpath=""
      fi
   fi
}

set_environment()
{
   if [ -z "${PATH}" ]; then
      PATH=$old_rootsys_before_CLA/bin; export PATH
   else
      PATH=$old_rootsys_before_CLA/bin:$PATH; export PATH
   fi

   if [ -z "${LD_LIBRARY_PATH}" ]; then
      LD_LIBRARY_PATH=$old_rootsys_before_CLA/lib
      export LD_LIBRARY_PATH       # Linux, ELF HP-UX
   else
      LD_LIBRARY_PATH=$old_rootsys_before_CLA/lib:$LD_LIBRARY_PATH
      export LD_LIBRARY_PATH
   fi

   if [ -z "${DYLD_LIBRARY_PATH}" ]; then
      DYLD_LIBRARY_PATH=$old_rootsys_before_CLA/lib
      export DYLD_LIBRARY_PATH       # Linux, ELF HP-UX
   else
      DYLD_LIBRARY_PATH=$old_rootsys_before_CLA/lib:$DYLD_LIBRARY_PATH
      export DYLD_LIBRARY_PATH
   fi

   if [ -z "${SHLIB_PATH}" ]; then
      SHLIB_PATH=$old_rootsys_before_CLA/lib
      export SHLIB_PATH       # Linux, ELF HP-UX
   else
      SHLIB_PATH=$old_rootsys_before_CLA/lib:$SHLIB_PATH
      export SHLIB_PATH
   fi

   if [ -z "${LIBPATH}" ]; then
      LIBPATH=$old_rootsys_before_CLA/lib
      export LIBPATH       # Linux, ELF HP-UX
   else
      LIBPATH=$old_rootsys_before_CLA/lib:$LIBPATH
      export LIBPATH
   fi

   if [ -z "${PYTHONPATH}" ]; then
      PYTHONPATH=$old_rootsys_before_CLA/lib
      export PYTHONPATH       # Linux, ELF HP-UX
   else
      PYTHONPATH=$old_rootsys_before_CLA/lib:$PYTHONPATH
      export PYTHONPATH
   fi

   if [ -z "${MANPATH}" ]; then
      MANPATH=$old_rootsys_before_CLA/man:${default_manpath}; export MANPATH
   else
      MANPATH=$old_rootsys_before_CLA/man:$MANPATH; export MANPATH
   fi

   if [ -z "${CMAKE_PREFIX_PATH}" ]; then
      CMAKE_PREFIX_PATH=$old_rootsys_before_CLA; export CMAKE_PREFIX_PATH       # Linux, ELF HP-UX
   else
      CMAKE_PREFIX_PATH=$old_rootsys_before_CLA:$CMAKE_PREFIX_PATH; export CMAKE_PREFIX_PATH
   fi

   if [ -z "${JUPYTER_PATH}" ]; then
      JUPYTER_PATH=$old_rootsys_before_CLA/etc/notebook; export JUPYTER_PATH       # Linux, ELF HP-UX
   else
      JUPYTER_PATH=$old_rootsys_before_CLA/etc/notebook:$JUPYTER_PATH; export JUPYTER_PATH
   fi

   if [ -z "${JUPYTER_CONFIG_DIR}" ]; then
      JUPYTER_CONFIG_DIR=$old_rootsys_before_CLA/etc/notebook; export JUPYTER_CONFIG_DIR # Linux, ELF HP-UX
   else
      JUPYTER_CONFIG_DIR=$old_rootsys_before_CLA/etc/notebook:$JUPYTER_CONFIG_DIR; export JUPYTER_CONFIG_DIR
   fi
}


### main ###


#if [ -n "${ROOTSYS}" ] ; then
#   old_rootsys=${ROOTSYS}
#fi


#SOURCE=${BASH_ARGV[0]}
#if [ "x$SOURCE" = "x" ]; then
#   SOURCE=${(%):-%N} # for zsh
#fi
#
#
#if [ "x${SOURCE}" = "x" ]; then
#   if [ -f bin/thisroot.sh ]; then
#      ROOTSYS="$PWD"; export ROOTSYS
#   elif [ -f ./thisroot.sh ]; then
#      ROOTSYS=$(cd ..  > /dev/null; pwd); export ROOTSYS
#   else
#      echo ERROR: must "cd where/root/is" before calling ". bin/thisroot.sh" for this version of bash!
#      ROOTSYS=; export ROOTSYS
#      return 1
#   fi
#else
#   # get param to "."
#   thisroot=$(dirname ${SOURCE})
#   ROOTSYS=$(cd ${thisroot}/.. > /dev/null;pwd); export ROOTSYS
#fi


clean_environment
#set_environment

if [ -n "${old_rootsys_before_CLA}" ] ; then
   set_environment
fi


# Prevent Cppyy from checking the PCH (and avoid warning)
#export CLING_STANDARD_PCH=none
#
#if [ "x`root-config --arch | grep -v win32gcc | grep -i win32`" != "x" ]; then
#   ROOTSYS="`cygpath -w $ROOTSYS`"
#fi

ROOTSYS=$old_rootsys_before_CLA

unset old_rootsys
unset old_rootsys_before_CLA
unset thisroot
unset -f drop_from_path
unset -f clean_environment
unset -f set_environment
