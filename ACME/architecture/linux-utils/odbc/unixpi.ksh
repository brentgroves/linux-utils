#!/bin/ksh
#
#       DataDirect UNIX OpenAccess ODBC Client installation script
#  Copyright(c) 1992-2008 DataDirect Technologies, Inc. All rights reserved.
#
#===============================================================================

#===============================================================================
#  toolkit.sh :
# DataDirect SequeLink UNIX installer
# Copyright (c) 1997-2004 DataDirect Technologies Corp. All Rights Reserved
#
#===============================================================================

#-------------------------------------------------------------------------------
#  Global init
#-------------------------------------------------------------------------------
TEMP_FILE="sequelnk.tmp"
LOGFILE=/dev/null
TARXF="tar -xof"

#===============================================================================
#  Ini functions (rscshell implementation)
#    These functions are case insensitive for <section> and <key>
#    Spaces and tabs are allowed before and/or after '='
#===============================================================================

#-------------------------------------------------------------------------------
#  Ini_Section_Create
#    Creates a section if it does not exists
#  usage : Ini_Section_Create <file> <section>
#-------------------------------------------------------------------------------
Ini_Section_Create ()
  {
  ./rscshell 1 "$1" "$2"
  }

#-------------------------------------------------------------------------------
#  Ini_Section_Delete
#    Deletes a section and al it's keys
#  usage : Ini_Section_Delete <file> <section>
#-------------------------------------------------------------------------------
Ini_Section_Delete ()
  {
  ./rscshell 2 "$1" "$2"
  }

#-------------------------------------------------------------------------------
#  Ini_Section_ListKeys
#  usage : Ini_Section_ListKeys <file> <section>
#-------------------------------------------------------------------------------
Ini_Section_ListKeys()
  {
  ./rscshell 3 "$1" "$2"
  }

#-------------------------------------------------------------------------------
#  Ini_Section_ReadKey
#  usage : Ini_Section_ReadKey <file> <section> <key>
#-------------------------------------------------------------------------------
Ini_Section_ReadKey()
  {
  ./rscshell 4 "$1" "$2" "$3"
  }

#-------------------------------------------------------------------------------
#  Ini_Section_WriteKey
#    Writes a key-value pair in a section. section must exist!
#  usage : Ini_Section_WriteKey <file> <section> <key> <value>
#-------------------------------------------------------------------------------
Ini_Section_WriteKey ()
  {
  ./rscshell 5 "$1" "$2" "$3" "$4"
  }

#-------------------------------------------------------------------------------
#  Ini_Section_DeleteKey
#    Deletes a key-value pair from a section.
#  usage : Ini_Section_DeleteKey <file> <section> <key>
#-------------------------------------------------------------------------------
Ini_Section_DeleteKey ()
  {
  ./rscshell 6 "$1" "$2" "$3"
  }

#===============================================================================
#  Ini functions (Korn shell implementation)
#    These functions are case sensitive for <section> and <key>
#    Spaces and tabs are allowed before and/or after '='
#    Metacharacters for 'sed' are NOT allowed in <section>
#===============================================================================

#-------------------------------------------------------------------------------
#  Ini_Section_ReadMsg
#  usage : Ini_Section_ReadMsg <file> <section>
#-------------------------------------------------------------------------------
Ini_Section_ReadMsg()
{
SECTION="^\[$2\]"
ENDSECTION="^\["
eval sed -ne '/"$SECTION"/,/"$ENDSECTION"/p' "$1" 2>> "$LOGFILE" \
    | grep -v "$ENDSECTION"
}

#-------------------------------------------------------------------------------
#  Ini_Section_DoCommand
#  usage : Ini_Section_DoCommand <file> <section>
#-------------------------------------------------------------------------------
Ini_Section_DoCommand()
{
SECTION="^\[$2\]"
ENDSECTION="^\["
eval "`eval sed -ne '/$SECTION/,/$ENDSECTION/p' $1 2>> "$LOGFILE" \
    | grep -v $ENDSECTION`"
}

#-------------------------------------------------------------------------------
#  Ini_Section_Create_ksh
#    Creates a section if it does not exists
#  usage : Ini_Section_Create_ksh <file> <section>
#    special characters in <section> must be escaped!
#-------------------------------------------------------------------------------
Ini_Section_Create_ksh ()
{
SECTION="^\[$2\]"
if [ -z "`grep "$SECTION" "$1" 2> /dev/null`" ] ; then
  echo "[$2]" >> $1
fi
}

#-------------------------------------------------------------------------------
#  Ini_Section_Delete_ksh
#    Deletes a section and al it's keys
#  usage : Ini_Section_Delete_ksh <file> <section>
#    special characters in <section> must be escaped!
#-------------------------------------------------------------------------------
Ini_Section_Delete_ksh ()
{
SECTION="[$2]"
unset INSECTION
rm $TEMP_FILE 2> /dev/null

while read x; do
  if [ "$x" = "$SECTION" ] ; then
    INSECTION="Y"
  elif [ "[" = "${x%%[![]*}" ] ; then
    INSECTION="N"
  fi
  if [ "$INSECTION" != "Y" ] ; then
    echo "$x" >>$TEMP_FILE
  fi
done < $1
cat $TEMP_FILE > $1
rm $TEMP_FILE 2> /dev/null
}

#-------------------------------------------------------------------------------
#  Ini_Section_ListKeys_ksh
#  usage : Ini_Section_ListKeys_ksh <file> <section>
#    special characters in <section> must be escaped twice!
#-------------------------------------------------------------------------------
Ini_Section_ListKeys_ksh()
{
SECTION="^\[$2\]"
ENDSECTION="^\["
eval sed -ne '/"$SECTION"/,/"$ENDSECTION"/p' "$1" 2>> "$LOGFILE" \
    | grep -v "$ENDSECTION" | awk -F= '{print$1}'
}

#-------------------------------------------------------------------------------
#  Ini_Section_ReadKey_ksh
#  usage : Ini_Section_ReadKey_ksh <file> <section> <key>
#    special characters in <section> must be escaped twice!
#-------------------------------------------------------------------------------
Ini_Section_ReadKey_ksh()
{
RET=`eval sed -ne '/"^\[$2\]"/,/"^\["/p' "$1" 2>> "$LOGFILE" \
    | grep -v "^\[" | tr -d "\011" | grep "^$3[ 	]*=" \
    | awk -F= '{print$2}' | tr -d "\011"`
echo ${RET## }
}

#-------------------------------------------------------------------------------
#  Ini_Section_WriteKey_ksh
#    Writes a key-value pair in a section. section must exist!
#  usage : Ini_Section_WriteKey_ksh <file> <section> <key> <value>
#    special characters in <section> must be escaped!
#-------------------------------------------------------------------------------
Ini_Section_WriteKey_ksh ()
{
SECTION="[$2]"
unset INSECTION
rm $TEMP_FILE 2> /dev/null

while read x;
do
  if [ "$x" = "[$2]" ] ;then
    INSECTION="Y"
    echo "$x" >>$TEMP_FILE
    echo "$3=$4" >>$TEMP_FILE
  elif [ "[" = "${x%%[![]*}" ] ;then
    INSECTION="N"
    echo "$x" >>$TEMP_FILE
  elif [[ "$INSECTION" != "Y" || -z `echo "$x" | tr -d "\011" | grep "^$3[ 	]*="` ]] ;then
    echo "$x" >>$TEMP_FILE
  fi
done < $1

cat $TEMP_FILE > $1
rm $TEMP_FILE 2> /dev/null
}

#-------------------------------------------------------------------------------
#  Ini_Section_DeleteKey_ksh
#    Deletes a key-value pair from a section.
#  usage : Ini_Section_DeleteKey_ksh <file> <section> <key>
#    special characters in <section> must be escaped!
#-------------------------------------------------------------------------------
Ini_Section_DeleteKey_ksh ()
{
SECTION="[$2]"
unset INSECTION
rm $TEMP_FILE 2> /dev/null

while read x; do
  if [ "$x" = "$SECTION" ] ;then
    INSECTION="Y"
  elif [ "[" = "${x%%[![]*}" ] ;then
    INSECTION="N"
  fi

  if [[ "$INSECTION" != "Y" || -z `echo "$x" | tr -d "\011" | grep "^$3[ 	]*="` ]] ;then
    echo "$x" >>$TEMP_FILE
  fi
done < $1
cat $TEMP_FILE > $1
rm $TEMP_FILE 2> /dev/null
}

#===============================================================================
#  Miscellaneous functions
#===============================================================================

#-------------------------------------------------------------------------------
#  Log_Create
#-------------------------------------------------------------------------------
Log_Create()
{
let i=1
while :
do
  LOGFILE="$1$i"
  if [ ! -a "$LOGFILE" ] ; then
    break
  fi
  let i=i+1
done
echo                                       >  "$LOGFILE"
Ini_Section_DoCommand "$MSGFILE" LogBanner >> "$LOGFILE"
}

#-------------------------------------------------------------------------------
#  Log_WriteString
#  usage: Log_WriteString <filename> <string>
#-------------------------------------------------------------------------------
Log_WriteString ()
{
eval echo "$2" >> $1
}

#-------------------------------------------------------------------------------
#  Log_WriteVar
#  usage: Log_WriteVar <filename> <varname>
#-------------------------------------------------------------------------------
Log_WriteVar ()
{
eval echo "$2="$"$2" >> $1
}

#-------------------------------------------------------------------------------
#  Dir_Create
#    Creates a directory, if it does not exists
#  usage: Dir_Create <dir> <mode>
#-------------------------------------------------------------------------------
Dir_Create ()
{
if [ ! -d "$1" ]; then
  Log_WriteString "$LOGFILE" "$CREATEDIR $1"
  mkdir -p "$1" 2> $TEMP_FILE
  if [ $? -ne 0 ] ; then
   cat $TEMP_FILE | tee -a "$LOGFILE"
   rm $TEMP_FILE 2> /dev/null
   return 1
  else
   rm $TEMP_FILE 2> /dev/null
   if [ -n "$2" ] ; then
     chmod "$2" "$1" 2> /dev/null
   fi
   return 0
  fi
fi
}


#-------------------------------------------------------------------------------
#  File_Copy
#    Copies a single file
#  usage: File_Copy <source> <target> <overwritemode>
#-------------------------------------------------------------------------------
File_Copy ()
{
error=0
if [ -d "$2" ] ; then
  print -n "`Ini_Section_ReadMsg "$MSGFILE" MsgDirExists`" | tee -a "$LOGFILE"
  echo "$2" | tee -a "$LOGFILE"
  return 1
fi

from=`ls -i "$1" 2> /dev/null | awk '{print $1}'`
to=`ls -i "$2"   2> /dev/null | awk '{print $1}'`
if [ \( -n "$2" \) -a \( "$from" != "$to" \) ] ; then
  Dir_Create "${2%/*}"
  if [ -a "$2" ] ; then
    case "$3" in

    # always overwrite
    A|a)
    eval echo "$COPYFILE"          | tee -a "$LOGFILE"
    rm -f "$2";cp -p "$1" "$2"
    error=$?
    break
    ;;

    # never overwrite
    N|n)
    Log_WriteString "$LOGFILE" "$SKIPFILE $2"
    return 0
    ;;

    # overwrite older
    O|o)
    if [ ! "$1" -ot "$2" ] ; then
      eval echo "$COPYFILE"        | tee -a "$LOGFILE"
      rm -f "$2";cp -p "$1" "$2"
      error=$?
      break
    else
      Log_WriteString "$LOGFILE" "$SKIPFILE $2"
      return 0
    fi
    ;;

    *)
    Ini_Section_ReadMsg "$MSGFILE" MsgOverwrite
    echo "$2"
    QueryYN "`Ini_Section_ReadMsg "$MSGFILE" QueryOverwrite`"
    if [ "$ANSWER" = "$N" ] ; then
      Log_WriteString "$LOGFILE" "$SKIPFILE $2"
      return 0
    else
      eval echo "$COPYFILE"        | tee -a "$LOGFILE"
      rm -f "$2";cp -p "$1" "$2"
      error=$?
      break
    fi
    ;;
    esac
  else
    eval echo "$COPYFILE"          | tee -a "$LOGFILE"
      rm -f "$2";cp -p "$1" "$2"
    error=$?
  fi
fi

return $error
}

#-------------------------------------------------------------------------------
#  File_Backup
#    Copies a file to a backup copy in the same dir but with extra extension.
#  usage: File_Backup <file>
#-------------------------------------------------------------------------------
File_Backup ()
{
if [ -a "$1" ] ; then
  let i=1
  while :
  do
    FNAME="$1$i"
    if [ ! -a "$FNAME" ] ; then
      break
    fi
    let i=i+1
  done
  eval echo "$BACKUPFILE $FNAME" | tee -a "$LOGFILE"
  cp "$1" "$FNAME"
  return $?
fi
return 0
}

#-------------------------------------------------------------------------------
#  File_Extract
#    extracts a single file from tar
#  usage: File_Extract <tarfile> <file> <target> <overwritemode>
#  target must be a dir+filename or empty
#  The TARXF variable must be set to the correct command
#-------------------------------------------------------------------------------
File_Extract ()
{
exist=""
extract=""
error=0
if [ -a "$2" ] ; then
  exist=1
  case "$4" in

  # always overwrite
  A|a)
  chmod u+w $2               2> /dev/null
  extract=1
  `$TARXF $1 $2`
  error=$?
  ;;

  # never overwrite
  N|n)
  :
  ;;

  # overwrite older
  O|o)
  rm -f "$TEMP_FILE";cp -p "$2" "$TEMP_FILE"    2> /dev/null
  `$TARXF $1 $2`
  error=$?
  if [ ! "$2" -ot "$TEMP_FILE" ] ; then
    extract=1
    rm -f "$TEMP_FILE"
  else
    mv -f "$TEMP_FILE" "$2"   2> /dev/null
  fi
  ;;

  *)
  Ini_Section_ReadMsg "$MSGFILE" MsgOverwrite
  echo "$2"
  QueryYN "`Ini_Section_ReadMsg "$MSGFILE" QueryOverwrite`"
  if [ "$ANSWER" = "$N" ] ; then
    :
  else
    extract=1
    `$TARXF $1 $2`
    error=$?
  fi
  ;;
  esac
else
  extract=1
  `$TARXF $1 $2`
  error=$?
fi

if [ $error != 0 ] ; then
  return $error
fi

from=`ls -i "$2" 2> /dev/null | awk '{print $1}'`
to=`ls -i "$3"   2> /dev/null | awk '{print $1}'`
if [ -z "$from" ] ; then
  # if the untar didn't worked out, return an error
  Log_WriteString "$LOGFILE" "$NOTFOUND $2"
  return 1
fi

if [ \( -n "$3" \) -a \( "$from" != "$to" \) ] ; then
  # source != destination -> move/copy to target
  Dir_Create "${3%/*}"
  if [ -a "$3" ] ; then
    case "$4" in

    # always overwrite
    A|a)
    :
    ;;

    # never overwrite
    N|n)
    Log_WriteString "$LOGFILE" "$SKIPFILE $3"
    if [ -z "$exist" ] ; then
      rm -f "$2"                  2> /dev/null
    fi
    return 0
    ;;

    # overwrite older
    O|o)
    if [ ! "$2" -ot "$3" ] ; then
      :
    else
      Log_WriteString "$LOGFILE" "$SKIPFILE $3"
      if [ -z "$exist" ] ; then
        rm -f "$2"                2> /dev/null
      fi
      return 0
    fi
    ;;

    # interactive (default)
    *)
    Ini_Section_ReadMsg "$MSGFILE" MsgOverwrite
    echo "$2"
    QueryYN "`Ini_Section_ReadMsg "$MSGFILE" QueryOverwrite`"
    if [ "$ANSWER" = "$N" ] ; then
      Log_WriteString "$LOGFILE" "$SKIPFILE $3"
      if [ -z "$exist" ] ; then
        rm -f "$2"                2> /dev/null
      fi
      return 0
    else
      :
    fi
    ;;
    esac
  fi
    #do the move / copy
    eval echo "$EXTRACTFILE"     | tee -a "$LOGFILE"
    if [ -z "$exist" ] ; then
      mv -f "$2" "$3"
    else
      rm -f "$3";cp -p "$2" "$3"
    fi
    return $?
else
  # source == destination -> don't move
  if [ -n "$extract" ] ; then
    eval echo "$EXTRACTFILE"     | tee -a "$LOGFILE"
  else
    Log_WriteString "$LOGFILE" "$SKIPFILE $3"
  fi
  return 0
fi

return $error
}

#-------------------------------------------------------------------------------
#  Ini_Section_UntarFiles
#    Untars and moves all files in a section
#  usage : Ini_Section_UntarFiles <inifile> <section> <tarfile> <targetrootdir>
#  !The TARXF variable must be defined
#-------------------------------------------------------------------------------
Ini_Section_UntarFiles()
{
SECTION="^\[$2\]"
ENDSECTION="^\["
for x in `eval sed -ne '/"$SECTION"/,/"$ENDSECTION"/p' $1 2>> "$LOGFILE" \
    | grep -v "$SECTION" | grep -v "$ENDSECTION"`
do
  FROM=`eval echo $x | awk -F= '{print $1}'`
  if [ -n "$4" ] ; then
    TO="$4/"`eval echo $x | awk -F= '{print $2}'`
  else
    TO="./`eval echo $x | awk -F= '{print $2}'`"
  fi
  OVERWR=`eval echo $x | awk -F= '{print $3}'`
  MODE=`eval echo $x | awk -F= '{print $4}'`
  while :
  do
    File_Extract "$3" "$FROM" "$TO" "$OVERWR"
    if [ $? -ne 0 ] ; then
      Ini_Section_ReadMsg "$MSGFILE" MsgErrorExtract1 | tee -a "$LOGFILE"
      echo "$FROM"                                    | tee -a "$LOGFILE"
      Ini_Section_ReadMsg "$MSGFILE" MsgErrorExtract2
      QueryYNC_Yes "`Ini_Section_ReadMsg "$MSGFILE" MsgErrorExtract3`"
      case "$ANSWER" in
        $N)
        Log_WriteString "$LOGFILE" "$SKIPFILE $TO"
        break
        ;;
        $Y)
        continue
        ;;
        $C)
        return 1
        ;;
      esac
    fi

    if [ -n "$MODE" ] ; then
      chmod "$MODE" "$TO"
    fi
    break
  done
done
return 0
}

#-------------------------------------------------------------------------------
#  QueryYN
#
#  Queries for Y-es or N-o and puts the answer in ANSWER
#  The value of ANSWER will be either "Y" or "N"
#  usage : QueryYN <msg>
#    msg is the message that will be displayed on initially the screen
#    and repeated each time the user enters an invalid value
#-------------------------------------------------------------------------------
QueryYN ()
{
while :
do
  print -n "$1"
  read ANSWER
  case "$ANSWER" in
    $N)
      ANSWER="N"
      break
      ;;
    $Y)
      ANSWER="Y"
      break
      ;;
  esac
done
}

#-------------------------------------------------------------------------------
#  QueryYN_Yes
#
#  Queries for Y-es or N-o and puts the answer in ANSWER
#  The value of ANSWER will be either "Y" or "N"
#  The default is "Y"
#  usage : QueryYN_Yes <msg>
#    msg is the message that will be displayed on initially the screen
#    and repeated each time the user enters an invalid value
#-------------------------------------------------------------------------------
QueryYN_Yes ()
{
while :
do
  print -n "$1"
  read ANSWER
  if [ -z "$ANSWER" ] ; then
    ANSWER="Y"
    break
  fi

  case "$ANSWER" in
    $N)
      ANSWER="N"
      break
      ;;
    $Y)
      ANSWER="Y"
      break
      ;;
  esac
done
}

#-------------------------------------------------------------------------------
#  QueryYNC_Yes
#
#  Queries for Y(es), N(o) or C(ancel) and puts the answer in ANSWER.
#  The value of ANSWER will be "Y", "N" or "C".
#  The default answer is Y(es).
#  usage : QueryYNC_Yes <msg>
#    msg is the message that will be displayed on initially the screen
#    and repeated each time the user enters an invalid value
#-------------------------------------------------------------------------------
QueryYNC_Yes ()
{
while :
do
  print -n "$1"
  read ANSWER
  if [ -z "$ANSWER" ] ; then
    ANSWER="Y"
    break
  fi

  case "$ANSWER" in
    $N)
      ANSWER="N"
      break
      ;;
    $Y)
      ANSWER="Y"
      break
      ;;
    $C)
      ANSWER="C"
      break
      ;;
  esac
done
}

#-------------------------------------------------------------------------------
#  QueryYNC_No
#
#  Queries for Y(es), N(o) or C(ancel) and puts the answer in ANSWER.
#  The value of ANSWER will be "Y", "N" or "C".
#  The default answer is N(o).
#  usage : QueryYNC_No <msg>
#    msg is the message that will be displayed on initially the screen
#    and repeated each time the user enters an invalid value
#-------------------------------------------------------------------------------
QueryYNC_No ()
{
while :
do
  print -n "$1"
  read ANSWER
  if [ -z "$ANSWER" ] ; then
    ANSWER="N"
    break
  fi

  case "$ANSWER" in
    $N)
      ANSWER="N"
      break
      ;;
    $Y)
      ANSWER="Y"
      break
      ;;
    $C)
      ANSWER="C"
      break
      ;;
  esac
done
}

#-------------------------------------------------------------------------------
#  QueryLicense
#-------------------------------------------------------------------------------
QueryLicense ()
{
Ini_Section_ReadMsg "$MSGFILE" LicenseBanner | more
while :
do
  print -n "`Ini_Section_ReadMsg "$MSGFILE" QueryLicense`"
  read ANSWER
  case "$ANSWER" in
    $NO)
      ANSWER=N
      break
      ;;
    $YES)
      ANSWER=Y
      break
      ;;
  esac
done
}

#-------------------------------------------------------------------------------
#  DetectMachineType
#-------------------------------------------------------------------------------
DetectMachineType ()
  {
  unset MACHINETYPE
  UNAME=`uname -s`

  SINIXPRESENT="`echo "$UNAME" | grep "SINIX" | wc -l | sed 's/ //g'`"
  if [ "$SINIXPRESENT" -gt 0 ] ; then
#Just because SINIX has SINIX-? characters for its UNAME e.g. SINIX-N, SINIX-Y
    UNAME="SINIX"
  fi

  case $UNAME in
    "AIX")
    VERSION=`uname -v`
    if [ \( "$VERSION" = "4" \) -o \( "$VERSION" = "5" \) -o \( "$VERSION" = "6" \) -o \( "$VERSION" = "7" \) ] ; then
      MACHINETYPE="AIX"
    fi
    ;;

    "HP-UX")
    VERSION=`uname -r | sed 's/..\(..\).*/\1/'`
    if [ "$VERSION" = "11" ] ; then
      HPARCH=`uname -m`
      if [ "$HPARCH" = "ia64" -a "$INST_XPADE" != "YES" ] ; then
        MACHINETYPE="HPUX11ia64"
      else
        MACHINETYPE="HPUX11"
      fi
    fi

    ;;

    "SunOS")
    VERSION=`uname -r | sed 's/\(.\).*/\1/'`
    if [ "$VERSION" = "5" ] ; then
       processor=`uname -p`
       if [ "$processor" = "i386" ] ; then
         MACHINETYPE="Solarisx86"
       else
         MACHINETYPE="Solaris"
       fi
    fi
    ;;

    "SINIX")
#Provision to detect 5.43 along with 5.42
    VERSION=`uname -r | sed 's/\(...\).*/\1/'`
    if [ "$VERSION" = "5.4" ] ; then
      MACHINETYPE="SINIX-N"
    fi
    ;;

    "dgux")
    VERSION=`uname -r`
    processor=`uname -p`
    if [ "$processor" = "Pentium" ] ; then
         MACHINETYPE="DGINTEL"
    else
         MACHINETYPE="DGRISC"
    fi
    ;;

    "OSF1")
    VERSION=`uname -r | sed 's/\(..\).*/\1/'`
    if [ "$VERSION" = "V3" ] ; then
      MACHINETYPE="OSF1_3" ;
    elif [ "$VERSION" = "V4" ] ; then
      MACHINETYPE="OSF1_4" ;
    elif [ "$VERSION" = "V5" ] ; then
      MACHINETYPE="OSF1_5" ;
    fi
    ;;

    "Linux")
    VERSION=`uname -r`
    MACHINETYPE="LINUX"
    ;;

    "NONSTOP_KERNEL")
    VERSION=`uname -r`
    MACHINETYPE="NONSTOP_KERNEL"
    ;;

    "OS/390")
    VERSION=`uname -r`
    MACHINETYPE="USS"
    ;;

    "UnixWare")
    VERSION=`uname -r`
    MACHINETYPE="UnixWare"
    ;;

    *)
    return 1
    ;;
  esac
  return 0
  }

#-------------------------------------------------------------------------------
#  Profile_ListVars <profile> <variable>
#    Reads vars from ksh profile
#-------------------------------------------------------------------------------
Profile_ListVars ()
  {
  if [ -n "$2" ] ; then
    cat "$1" 2>> "$LOGFILE"                            |\
    # split lines
    awk -F';' '{ for (i = 1; i <= NF; i++) print $i }' |\
    # filter out comment lines
    grep -v '^[ 	]*#'                           |\
    # do the grep and print after '='
    egrep "(^$2=)|([ 	]+$2=)" | awk -F= '{print$2}' |\
	 # filter out `...` lines, we do not list them as possibilities
	 grep -v "^[ 	]*\`.*\`"
  fi
  }

#-------------------------------------------------------------------------------
#  bash_ListVars <homedir> <variable>
#    Reads vars from .bash_profile in homedir
#-------------------------------------------------------------------------------
bash_ListVars ()
  {
  Profile_ListVars "$1/.bash_profile" "$2"
  }

#-------------------------------------------------------------------------------
#  ksh_ListVars <homedir> <variable>
#    Reads vars from .profile in homedir
#-------------------------------------------------------------------------------
ksh_ListVars ()
  {
  Profile_ListVars "$1/.profile" "$2"
  }

#-------------------------------------------------------------------------------
#  profile_RecListVars <homedir> <profile-name> <variable>
#    Reads vars from .profile in homedir and from all other referenced .profile
#-------------------------------------------------------------------------------
profile_RecListVars()
  {
  # read from .profile
  ksh_ListVars "$1/$2" "$3"
  # get all referenced .profile
  list=`cat "$1/$2" 2>> "$LOGFILE"                         |\
        # split lines
        awk -F';' '{ for (i = 1; i <= NF; i++) print $i }' |\
        # parse out comment lines
        grep -v '^[ 	]*#' "$1"/.profile                    |\
        # get the lines which execute another .profile
        grep ".*\. .*\.profile"                            |\
        # get the directory of the .profile
        sed 's/.*\.[    ]*//' | sed 's/\/\$2[   ]*$//'`
  if [ -n "$list" ] ; then
    for i in $list ; do
	   ksh_ListVars "$i/$2" "$3"
    done
  fi
  }

#-------------------------------------------------------------------------------
#  csh_ListVars <homedir> <variable>
#    Reads vars from .cshrc and .login in homedir
#-------------------------------------------------------------------------------
csh_ListVars ()
  {
  if [ -n "$2" ] ; then
    cat "$1/.cshrc" "$1/.login" 2>> "$LOGFILE"         |\
    # split lines
    awk -F';' '{ for (i = 1; i <= NF; i++) print $i }' |\
    # filter out comment lines
    grep -v '^[ 	]*#'                           |\
    # change setenv <var> to <var>=
    sed "s/setenv[ 	][ 	]*$2[ 	]/$2=/"        |\
    # do the grep and print after '='
    egrep "(^$2[ 	]*=)|([ 	]+$2[ 	]*=)" | awk -F= '{print$2}' |\
    # eat whitespace
    sed 's/^[ 	]*//'
   fi
  }

#-------------------------------------------------------------------------------
#  Etc_ListVars <file> <variable>
#    List vars in second column from /etc/syslog, or other scripts
#    where the column delimiter is whitespace.
#    Lines starting with '#' are filtered out.
#-------------------------------------------------------------------------------
Etc_ListVars ()
  {
  if [ -n "$2" ] ; then
    cat "$1" 2>> "$LOGFILE"                      |\
    # filter out comment lines
    grep -v '^[ 	]*#'                           |\
    # do the grep and print the second column
    egrep "^$2[ 	]+" | awk '{print$2}'
  fi
  }




#
# License registration (based on Connect ODBC 5.3)
#
# CreateLicFile
#	GetLICInfo
#	GetIPEKey
# DisplayLICInfo
# PreValidateIPEKey
# LicenseInfoOk
# GetRegistrationInfo

#-------------------------------------------------------------------------------
# CreateLicFile()
# Usage a> CreateLicFile 0 ==> Don't delete the IVODBC.LIC file. And also at
#				this point of time we also know the driver name
#				if the single driver has to be installed.
# 	   CreateLicFile 1 ==> If IVODBC.LIC file is created successfully
#				by makelic utility then remove it.
# 	   CreateLicFile 2 ==> Validates the IPE Key entered, but does not create
#				the license file.
#
# **IMP** This is all beacuse of the strange sequence reqd in mi and pi ...
# Assumption : IVODBC.LIC is the license file name for ODBC spec.
#-------------------------------------------------------------------------------
CreateLicFile()
{
if [ $1 -eq 1 ] ; then
	eval "$MAKELIC \"$PACK_OR_SINGLEDRV\" \"$LIC_IPEKey\""
	retCode="$?"
elif [ $1 -eq 0 ] ; then
	eval "$MAKELIC $LICFILENAME \"$LIC_UserName\" \"$LIC_Company\" \"$LIC_SerialNo\" \"$LIC_IPEKey\" \"$LICDIR\" \"$MACHINETYPE\" \"$TOINSTALL\""
	retCode="$?"
elif [ $1 -eq 2 ] ; then
	eval "$MAKELIC \"$LIC_IPEKey\""
	retCode="$?"
fi
return $retCode
}

#-------------------------------------------------------------------------------
#  GetLICInfo
#-------------------------------------------------------------------------------
GetLICInfo()
{
	print -n "`Ini_Section_ReadMsg "$MSGFILEABS" LIC_UserName`"
	read LIC_UserName
	print -n "`Ini_Section_ReadMsg "$MSGFILEABS" LIC_Company`"
	read LIC_Company
	print -n "`Ini_Section_ReadMsg "$MSGFILEABS" LIC_SerialNo`"
	read LIC_SerialNo

	#Check for valid User Name, Company Name and Serial Number
	if [ "$LIC_UserName" = "" ] ; then
		Ini_Section_ReadMsg "$MSGFILEABS" LIC_EmptyField
		Ini_Section_ReadMsg "$MSGFILEABS" LIC_RetypeInfo
		GetLICInfo
	elif [ "$LIC_Company" = "" ] ; then
		Ini_Section_ReadMsg "$MSGFILEABS" LIC_EmptyField
		Ini_Section_ReadMsg "$MSGFILEABS" LIC_RetypeInfo
		GetLICInfo
	elif [ "$LIC_SerialNo" = "" ] ; then
		Ini_Section_ReadMsg "$MSGFILEABS" LIC_EmptyField
		Ini_Section_ReadMsg "$MSGFILEABS" LIC_RetypeInfo
		GetLICInfo
	fi
}
#-------------------------------------------------------------------------------
#  GetIPEKey
#-------------------------------------------------------------------------------
GetIPEKey()
{
	print -n "`Ini_Section_ReadMsg "$MSGFILEABS" LIC_IPEKey`"
	read LIC_IPEKey
}
#-------------------------------------------------------------------------------
#  DisplayLICInfo
#-------------------------------------------------------------------------------
DisplayLICInfo()
{
	Ini_Section_ReadMsg "$MSGFILEABS" LIC_DisplayInfoStart
	print -n "`Ini_Section_ReadMsg "$MSGFILEABS" LIC_UserName`"
	print "$LIC_UserName"
	print -n "`Ini_Section_ReadMsg "$MSGFILEABS" LIC_Company`"
	print "$LIC_Company"
	print -n "`Ini_Section_ReadMsg "$MSGFILEABS" LIC_SerialNo`"
	print "$LIC_SerialNo"
	print -n "`Ini_Section_ReadMsg "$MSGFILEABS" LIC_IPEKey`"
	print "$LIC_IPEKey"
	Ini_Section_ReadMsg "$MSGFILEABS" LIC_DisplayInfoEnd
}

#-------------------------------------------------------------------------------
# PreValidateIPEKey()
#-------------------------------------------------------------------------------
PreValidateIPEKey()
{
	CreateLicFile 2
	ERRCHK="$?"
	while [[ $ERRCHK -eq 2 || $ERRCHK -eq 10 || $ERRCHK -eq 11 ]]
	do
		case "$ERRCHK" in
		2)
			Ini_Section_ReadMsg "$MSGFILEABS" LIC_WrongIPEKEY
			;;
		10)
			Ini_Section_ReadMsg "$MSGFILEABS" LIC_WrongNumberOFProcessors
			;;
		11)
			Ini_Section_ReadMsg "$MSGFILEABS" LIC_WrongOSIPEKEY
			;;
		esac

		print -n "`Ini_Section_ReadMsg "$MSGFILEABS" LIC_InvalidIPEPrompt`"
		read ANSWER
		if [ -z "$ANSWER" ] ; then
			return 22 # EVAL-key
		elif [ "$ANSWER" = "E" ] ; then
			Ini_Section_ReadMsg "$MSGFILEABS" LIC_EXIT
			exit 0
		elif [ "$ANSWER" = "e" ] ; then
			Ini_Section_ReadMsg "$MSGFILEABS" LIC_EXIT
			exit 0
		fi
    # reAsk key
		print ""
		GetIPEKey
		CreateLicFile 2
		ERRCHK="$?"
	done

	return "$ERRCHK"
}
#-------------------------------------------------------------------------------
# ProcessIPEey()
#-------------------------------------------------------------------------------
ProcessIPEKey()
{
	IPEKEY="$1"
	case "$IPEKEY" in
	12)
		PACK_OR_SINGLEDRV="SINGLEDRIVER"
		LIC_DrvName="DB2"
		echo "You have chosen the DB2 Wire Protocol driver."
		return 0;
		break
		;;
	13)
		PACK_OR_SINGLEDRV="SINGLEDRIVER"
		LIC_DrvName="DB2"
		echo ""
		echo "You have chosen the DB2 Wire Protocol driver."
		echo ""
		return 0;
		break
		;;
	14)
		PACK_OR_SINGLEDRV="SINGLEDRIVER"
		LIC_DrvName="dBASE"
		echo ""
		echo "You have chosen the dBASE driver."
		echo ""
		return 0;
		break
		;;
	15)
		PACK_OR_SINGLEDRV="SINGLEDRIVER"
		LIC_DrvName="Informix"
		if [ "$UNAME" = "Linux" -o "$MACHINETYPE" = "HPUX1164" ] ; then
			echo ""
			echo "You have chosen the Informix Wire Protocol driver."
			echo ""
		else
			echo ""
			echo "You have chosen the Informix Wire Protocol and Informix (client) drivers."
			echo ""
		fi
		return 0;
		break
		;;
	16)
		PACK_OR_SINGLEDRV="SINGLEDRIVER"
		LIC_DrvName="Oracle"
		if [ "$MACHINETYPE" = "SolarisX86" ] ; then
			echo ""
			echo "You have chosen the Oracle Wire Protocol driver."
			echo ""
		else
			echo ""
			echo "You have chosen the Oracle Wire Protocol and Oracle (client) drivers."
			echo ""
		fi
		return 0;
		break
		;;
	18)
		PACK_OR_SINGLEDRV="SINGLEDRIVER"
		LIC_DrvName="SQL Server"
		echo ""
		echo "You have chosen the SQL Server Wire Protocol driver."
		echo ""
		return 0;
		break
		;;
	19)
		PACK_OR_SINGLEDRV="SINGLEDRIVER"
		LIC_DrvName="Sybase"
		echo ""
		echo "You have chosen the Sybase Wire Protocol driver."
		echo ""
		return 0;
		break
		;;
	20)
		PACK_OR_SINGLEDRV="SINGLEDRIVER"
		LIC_DrvName="Text"
		echo ""
		echo "You have chosen the Text driver."
		echo ""
		return 0;
		break
		;;
	21)
		PACK_OR_SINGLEDRV="ALL"
		echo ""
		echo "You have chosen All drivers."
		echo ""
		return 0;
		break
		;;
	22)
		LIC_DrvName="EVAL"
		LIC_IPEKey="EVAL"
		echo ""
		echo "You have chosen an Evaluation."
		echo ""
		return 0;
		break
		;;
	23)
		LIC_DrvName="OEM"
		echo ""
		echo "You have chosen to install the OEM evaluation drivers."
		echo ""
		return 0;
		break
		;;
	24)
		PACK_OR_SINGLEDRV="SINGLEDRIVER"
		LIC_DrvName="Teradata"
		echo ""
		echo "You have chosen the Teradata driver."
		echo ""
		return 0;
		break
		;;
	26)
		LIC_DrvName="Driver Manager"
		echo ""
		echo "You have chosen to update the Driver Manager."
		echo ""
		return 0;
		break
		;;
	27)
		PACK_OR_SINGLEDRV="SINGLEDRIVER"
		LIC_DrvName="dBASE"
		echo ""
		echo "You have chosen the FoxPro driver."
		echo ""
		return 0;
		break
		;;
	30)
		PACK_OR_SINGLEDRV="SINGLEDRIVER"
		LIC_DrvName="OpenAccess"
		echo ""
		echo "You have chosen the OpenAccess driver."
		echo ""
		return 0;
		break
		;;
	esac

}

#-------------------------------------------------------------------------------
# LicenseInfoOk()
#-------------------------------------------------------------------------------
LicenseInfoOk()
{
	print -n "`Ini_Section_ReadMsg "$MSGFILEABS" LIC_ModifyInfoQ`"
	read ANSWER
	if [ -z "$ANSWER" ] ; then
		return 0
	else
		LIC_IPEKey=""
		Ini_Section_ReadMsg "$MSGFILEABS" LIC_RetypeInfo
		return 1
	fi
}

#-------------------------------------------------------------------------------
# GetRegistrationInfo ()
#-------------------------------------------------------------------------------
GetRegistrationInfo ()
{
#GetMakeLicenseUtilityPath set in main
while true
do
	Ini_Section_ReadMsg "$MSGFILEABS" LIC_GetInfo
	GetLICInfo
	GetIPEKey
	if [ "$LIC_IPEKey" != "EVAL" ] ; then
		DisplayLICInfo
	fi
	PreValidateIPEKey
	KEY="$?"
	ProcessIPEKey $KEY
	if [ $KEY = 1 ] ; then
		break # EVAL-LIC created
	else
		eval LicenseInfoOk
		retCode="$?"
		if [ $retCode -eq 0 ] ; then
		  break # User dont want ro change the key entered
		fi
	fi

done
}

# end of License registration (based on Connect ODBC 5.3)

#-------------------------------------------------------------------------------
#  Ini_Section_ListKeys_One
#  usage : Ini_Section_ListKeys_One <file> <section> <number>
#-------------------------------------------------------------------------------
Ini_Section_ListKeys_One()
{
SECTION="^\[$2\]"
ENDSECTION="^\["
eval sed -ne '/"$SECTION"/,/"$ENDSECTION"/p' "$1" 2>> $LOGFILE \
    | grep -v "$ENDSECTION" | awk -F= '{print$1}' | eval sed -ne '"$3"p'  | tr -d '\015'
}

#-------------------------------------------------------------------------------
#  QueryNum
#  reads a number in from the user
#  Verifies the value of ANSWER: Between val1 and val2
#  usage : QueryNum <val1> <val2>
#-------------------------------------------------------------------------------
QueryNum ()
{
while :
do
  print -n "`Ini_Section_ReadMsg "$MSGFILE" ValidNum`"
  print -n " $1 `Ini_Section_ReadMsg "$MSGFILE" ValidNumAnd` $2 : [$1] "
  read ANSWER

  case "$ANSWER" in
    ["$1"-"$2"])
      break;
      ;;
  esac

  if [ -z "$ANSWER" ]
  then
    ANSWER="$1"
    break
  fi
done
}

#-------------------------------------------------------------------------------
#  QueryYN_No
#
#  Queries for Y-es or N-o and puts the answer in ANSWER
#  The value of ANSWER will be either "Y" or "N"
#  The default is "N"
#  usage : QueryYN_No <msg>
#    msg is the message that will be displayed on initially the screen
#    and repeated each time the user enters an invalid value
#-------------------------------------------------------------------------------
QueryYN_No ()
{
while :
do
  print -n "$1"
  read ANSWER
  if [ -z "$ANSWER" ] ; then
    ANSWER="N"
    break
  fi

  case "$ANSWER" in
    $N)
      ANSWER="N"
      break
      ;;
    $Y)
      ANSWER="Y"
      break
      ;;
  esac
done
}

#-------------------------------------------------------------------------------
# configurate odbc.ini
#-------------------------------------------------------------------------------
OAODBC_Config_ODBCINI()
{
Log_WriteString $LOGFILE ""
Log_WriteString $LOGFILE "OAODBC_Config_ODBCINI start"

ODBC_INIFILE="$TARGETDIR/odbc$BUILD.ini"

# log the vars we use
Log_WriteVar $LOGFILE ODBC_INIFILE
Log_WriteVar $LOGFILE DRIVERFILE
Log_WriteVar $LOGFILE DRIVERDESCR
Log_WriteVar $LOGFILE MACHINETYPE
Log_WriteVar $LOGFILE LIBROOT
if [ "$BUILD" != "64" ] ; then
    Log_WriteVar $LOGFILE DRIVERTRC
else 
    Log_WriteVar $LOGFILE DRIVERTRC64
fi

if [ -r "$ODBC_INIFILE" ] ; then
   echo "Saving current odbc$BUILD.ini to odbc$BUILD.ini.$$"
   mv "$ODBC_INIFILE" "$ODBC_INIFILE.$$"
fi
echo "" > "$ODBC_INIFILE"
echo ";This is a template for the OpenAccess ODBC Driver data source. " >> "$ODBC_INIFILE"
echo "" >> "$ODBC_INIFILE"

echo "[ODBC Data Sources]" >> "$ODBC_INIFILE"
echo "DataSourceName=$DRIVERDESCR" >> "$ODBC_INIFILE"
echo >> "$ODBC_INIFILE"

echo "[DataSourceName]" >>"$ODBC_INIFILE"
echo Driver=$LIBROOT/$DRIVERFILE >> "$ODBC_INIFILE"
echo Description=$DRIVERDESCR >> "$ODBC_INIFILE"
echo Host=>> "$ODBC_INIFILE"
echo Port=>> "$ODBC_INIFILE"
echo ServerDataSource=>> "$ODBC_INIFILE"
echo UseLDAP=0 >> "$ODBC_INIFILE"
echo DistinguishedName=>> "$ODBC_INIFILE"
echo Encrypted=0 >> "$ODBC_INIFILE"
echo LoadBalancing=0 >> "$ODBC_INIFILE"
echo AlternateServers=>> "$ODBC_INIFILE"
echo ConnectionRetryCount=0 >> "$ODBC_INIFILE"
echo ConnectionRetryDelay=3 >> "$ODBC_INIFILE"
echo CustomProperties= >> "$ODBC_INIFILE"
echo "" >>"$ODBC_INIFILE"

echo "[ODBC]" >>"$ODBC_INIFILE"
echo Trace=0 >>"$ODBC_INIFILE"
echo IANAAppCodePage=4 >> "$ODBC_INIFILE"
echo TraceFile=odbctrace.out >> "$ODBC_INIFILE"

if [ "$BUILD" != "64" ] ; then
  echo TraceDll=$LIBROOT/$DRIVERTRC >> "$ODBC_INIFILE"
else
  echo TraceDll=$LIBROOT/$DRIVERTRC64 >> "$ODBC_INIFILE"
fi

echo InstallDir=$TARGETDIR >> "$ODBC_INIFILE"
echo "" >> "$ODBC_INIFILE"

chmod u=rw,go=r "$ODBC_INIFILE"

echo "The installer has successfully created an ODBCINI-file." | tee -a "$LOGFILE"
Log_WriteString $LOGFILE "OAODBC_Config_ODBCINI end"
}

#-------------------------------------------------------------------------------
# configurate odbcinst.ini
#-------------------------------------------------------------------------------
OAODBC_Config_ODBCINST()
{
Log_WriteString $LOGFILE ""
Log_WriteString $LOGFILE "OAODBC_Config_ODBCINST start"

ODBCINST_INFILE="$TARGETDIR/odbcinst.ini"

# log the vars we use
Log_WriteVar $LOGFILE ODBCINST_INFILE
Log_WriteVar $LOGFILE DRIVERFILE
Log_WriteVar $LOGFILE DRIVERDESCR

echo "" > "$ODBCINST_INFILE"
echo "[ODBC Drivers]" >> "$ODBCINST_INFILE"
echo "$DRIVERDESCR = Installed" >> "$ODBCINST_INFILE"
echo "" >> "$ODBCINST_INFILE"
echo "[$DRIVERDESCR]" >> "$ODBCINST_INFILE"
echo "APILevel = 1" >> "$ODBCINST_INFILE"
echo "ConnectFunctions = YYN" >> "$ODBCINST_INFILE"
echo "Driver = $DRIVERFILE" >> "$ODBCINST_INFILE"
echo "DriverODBCVer = 03.52" >> "$ODBCINST_INFILE"
echo "FileUsage = 0" >> "$ODBCINST_INFILE"
echo "SQLLevel = 1" >> "$ODBCINST_INFILE"
chmod u=rw,go=r "$ODBCINST_INFILE"

Log_WriteString $LOGFILE "OAODBC_Config_ODBCINST done"
}
#-------------------------------------------------------------------------------
# configurate csh env file
#-------------------------------------------------------------------------------
OAODBC_Config_CshEnvFile()
{
Log_WriteString $LOGFILE ""
Log_WriteString $LOGFILE "OAODBC_Config_CshEnvFile start"

FILEPREFIX=oaodbc
DOT_CSHFILENAME="$TARGETDIR/.${FILEPREFIX}$BUILD.csh"
CSHFILENAME="$TARGETDIR/${FILEPREFIX}$BUILD.csh"

# log the vars we use
Log_WriteVar $LOGFILE DOT_CSHFILENAME
Log_WriteVar $LOGFILE CSHFILENAME
Log_WriteVar $LOGFILE LIBPATHKEY
Log_WriteVar $LOGFILE BUILD
Log_WriteVar $LOGFILE LIBROOT

echo "if (\$?$LIBPATHKEY) then" > "$DOT_CSHFILENAME"
echo "  setenv $LIBPATHKEY $LIBROOT:\$$LIBPATHKEY" >> "$DOT_CSHFILENAME"
echo "else" >> "$DOT_CSHFILENAME"
echo "  setenv $LIBPATHKEY $LIBROOT" >> "$DOT_CSHFILENAME"
echo "endif" >> "$DOT_CSHFILENAME"
echo "setenv OASDK_ODBC_HOME $LIBROOT" >> "$DOT_CSHFILENAME"
echo "setenv ODBCINI $TARGETDIR/odbc$BUILD.ini" >> "$DOT_CSHFILENAME"
echo >> "$DOT_CSHFILENAME"

chmod u=rwx,go=rx "$DOT_CSHFILENAME"
ln -f "$DOT_CSHFILENAME" "$CSHFILENAME"

Log_WriteString $LOGFILE "OAODBC_Config_CshEnvFile done"
}
#-------------------------------------------------------------------------------
# configurate ksh env file
#-------------------------------------------------------------------------------
OAODBC_Config_kshEnvFile()
{
Log_WriteString $LOGFILE ""
Log_WriteString $LOGFILE "OAODBC_Config_kshEnvFile start"

FILEPREFIX=oaodbc
DOT_SHFILENAME="$TARGETDIR/.${FILEPREFIX}$BUILD.sh"
SHFILENAME="$TARGETDIR/${FILEPREFIX}$BUILD.sh"

# log the vars we use
Log_WriteVar $LOGFILE DOT_SHFILENAME
Log_WriteVar $LOGFILE SHFILENAME
Log_WriteVar $LOGFILE LIBPATHKEY
Log_WriteVar $LOGFILE BUILD
Log_WriteVar $LOGFILE LIBROOT

echo "$LIBPATHKEY=$LIBROOT\${$LIBPATHKEY:+\":\"}\${$LIBPATHKEY:-\"\"}" > "$DOT_SHFILENAME"
echo "export $LIBPATHKEY" >> "$DOT_SHFILENAME"
echo "OASDK_ODBC_HOME=$LIBROOT; export OASDK_ODBC_HOME" >> "$DOT_SHFILENAME"
echo "ODBCINI=$TARGETDIR/odbc$BUILD.ini; export ODBCINI" >> "$DOT_SHFILENAME"
echo >> "$DOT_SHFILENAME"

chmod u=rwx,go=rx "$DOT_SHFILENAME"
ln -f "$DOT_SHFILENAME"  "$SHFILENAME"

Log_WriteString $LOGFILE "OAODBC_Config_kshEnvFile done"
}
#-------------------------------------------------------------------------------
# configurate custom dir
#-------------------------------------------------------------------------------
OAODBC_Config_Custom()
{
Log_WriteString $LOGFILE ""
Log_WriteString $LOGFILE "OAODBC_Config_Custom start"

# create setenv.sh and setenv.csh
SETENV_SH="$TARGETDIR/custom/setup/cfg/setenv.sh"
SETENV_CSH="$TARGETDIR/custom/setup/cfg/setenv.csh"

echo "export ENV_MAKEFILE=$TARGETDIR/custom/setup/cfg/env.mk" > "$SETENV_SH"
echo "setenv ENV_MAKEFILE $TARGETDIR/custom/setup/cfg/env.mk" > "$SETENV_CSH"
chmod a=rx  $SETENV_SH $SETENV_CSH

# put the effective OAINSTALLDIR in connexit.mak
CONEXITDIR=$TARGETDIR/custom/setup/connexit

sed -e "/OAINSTALLDIR=/c\\
OAINSTALLDIR=${TARGETDIR}" "$CONEXITDIR/connexit.make" > "$CONEXITDIR/connexit.mak"
rm -f "$CONEXITDIR/connexit.make"

Log_WriteString $LOGFILE "OAODBC_Config_Custom done"
}

#-------------------------------------------------------------------------------
# configurate branding dir
#-------------------------------------------------------------------------------
OAODBC_Config_Branding()
{
Log_WriteString $LOGFILE ""
Log_WriteString $LOGFILE "OAODBC_Config_Branding start"

BRANDDIR="${TARGETDIR}/custom/branding"

mv "$BRANDDIR/oemoa.sh" "$BRANDDIR/oemoa.sh.org"

sed -e "/OAINSTDIR=/c\\
OAINSTDIR=${TARGETDIR}" -e "/BUILD=/c\\
BUILD=${BUILD}" "$BRANDDIR/oemoa.sh.org" > "$BRANDDIR/oemoa.sh"
rm -f "$BRANDDIR/oemoa.sh.org"
chmod +x "$BRANDDIR/oemoa.sh"

Log_WriteString $LOGFILE "OAODBC_Config_Branding done"
}

#-------------------------------------------------------------------------------
# OAODBC_Config_CUSTOM_MESSAGES
# configurate/complete custom/messages subdir
#-------------------------------------------------------------------------------
OAODBC_Config_CUSTOM_MESSAGES()
{
Log_WriteString ${LOGFILE} ""
Log_WriteString ${LOGFILE} "OAODBC_Config_CUSTOM_MESSAGES start"

CUSTOM_MESSAGES="${TARGETDIR}/custom/messages"
ICUDISTR_TAR="${TARGETDIR}/icudistr.tar"

ICUTOP="${CUSTOM_MESSAGES}/icu"

Log_WriteVar    ${LOGFILE} CUSTOM_MESSAGES
Log_WriteVar    ${LOGFILE} ICUDISTR_TAR
Log_WriteVar    ${LOGFILE} ICUTOP

Dir_Create "${CUSTOM_MESSAGES}/release" 755
Dir_Create "${ICUTOP}"                  755

( cd "${ICUTOP}" ; $TARXF "${ICUDISTR_TAR}" ) 2>&1 >> ${LOGFILE}
if [ $? -ne 0 ] ; then
  Ini_Section_ReadMsg $MSGFILE TarFileError | tee -a $LOGFILE
fi

# update genmsg.sh OAINSTALLDIR and LD_LIBRARY_PATH
GENMSG_SH="${CUSTOM_MESSAGES}/genmsg.sh"
GENMSG_ORG="${GENMSG_SH}_$$"
mv "${GENMSG_SH}" "${GENMSG_ORG}"
if [ "LD_LIBRARY_PATH" != "${LIBPATHKEY}" ] ; then
  SPEC_SED="/LD_LIBRARY_PATH/s/LD_LIBRARY_PATH/${LIBPATHKEY}/g"
else
  SPEC_SED="1s/ / /"
fi

# update genmsg.sh XARFLAGS
if [ "$MACHINETYPE" = "AIX"  -a "$BUILD" = "64" ] ; then
   XAR_SED="-X64 -xv" 
else 
   XAR_SED="-xv"
fi

sed -e "$SPEC_SED" -e "/OAINSTALLDIR=/c\\
OAINSTALLDIR=${TARGETDIR}" -e "/XARFLAGS=/c\\
XARFLAGS=\"${XAR_SED}\"" "${GENMSG_ORG}" > "${GENMSG_SH}"

chmod u=rwx,go=rx "${GENMSG_SH}"
rm -f "${GENMSG_ORG}"

# update icu/bin/icu-configset prefix=$ICUTOP
ICU_CONFIG="${ICUTOP}/bin/icu-config"
ICU_CONFIG_ORG="${ICU_CONFIG}_$$"
mv "${ICU_CONFIG}" "${ICU_CONFIG_ORG}"
sed -e "/^prefix/c\\
prefix=${ICUTOP}" "${ICU_CONFIG_ORG}" > "${ICU_CONFIG}"

chmod a=rx "${ICU_CONFIG}"
rm -f "${ICU_CONFIG_ORG}"

# update icu/lib/icu/4.2.1/Makefile.inc set prefix=$ICUTOP
ICU_MAKEFILE="${ICUTOP}/lib/icu/4.2.1/Makefile.inc"
ICU_MAKEFILE_ORG="${ICU_MAKEFILE}_$$"
mv "${ICU_MAKEFILE}" "${ICU_MAKEFILE_ORG}"
sed -e "/^prefix/c\\
prefix=${ICUTOP}" "${ICU_MAKEFILE_ORG}" > "${ICU_MAKEFILE}"

chmod a=r "${ICU_MAKEFILE}"
rm -f "${ICU_MAKEFILE_ORG}"

# set permission for files installed in languages
chmod a=r "${CUSTOM_MESSAGES}/languages/root.txt"
chmod a=r "${CUSTOM_MESSAGES}/languages/en.txt"
chmod u=rw,g=r "${CUSTOM_MESSAGES}/languages/reslist.txt"

mv $TARGETDIR/fixes_odbc.txt $TARGETDIR/fixes.txt
mv $TARGETDIR/readme_odbc.txt $TARGETDIR/readme.txt

rm -f "$ICUDISTR_TAR"

Log_WriteString $LOGFILE "OAODBC_Config_CUSTOM_MESSAGES done"
}
#-------------------------------------------------------------------------------
#  CheckPlatformSupport
#
#    Check which platform and OS version(s) this installer supports
#    called from GetMachineType()
#
#    This function sets 2 variable : PLATFORMSUPPORT and DISPLAYTYPE (for HP-UX)
#-------------------------------------------------------------------------------
CheckPlatformSupport ()
{
PLATFORMSUPPORT="`Ini_Section_ReadKey_ksh install.pi \"Platform Support\" PLATFORMSUPPORT`"
case $PLATFORMSUPPORT in
  "HPUX10x")
    if [ ! "$MACHINETYPE" = "HPUX1010" -a ! "$MACHINETYPE" = "HPUX1020" ] ; then
      Ini_Section_ReadMsg $MSGFILE HPUX10xNoSupport | tee -a $LOGFILE
      Ini_Section_ReadMsg "$MSGFILE" ExitFailure | tee -a $LOGFILE
      exit 1
    fi
    DISPLAYTYPE="HP-UX 10.10 - cFront Enabled"
  ;;
  "HPUX1020")
    if [ ! "$MACHINETYPE" = "HPUX1020" -a ! "$MACHINETYPE" = "HPUX11" ] ; then
      Ini_Section_ReadMsg $MSGFILE HPUX1020NoSupport | tee -a $LOGFILE
      Ini_Section_ReadMsg "$MSGFILE" ExitFailure | tee -a $LOGFILE
      exit 1
    fi
    DISPLAYTYPE="HP-UX 10.20 - aCC Enabled"
  ;;
  "HPUX11x")
    if [ "$MACHINETYPE" != "HPUX11" -a "$MACHINETYPE" != "HPUX11ia64" ] ; then
      Ini_Section_ReadMsg $MSGFILE HPUX11xNoSupport | tee -a $LOGFILE
      Ini_Section_ReadMsg "$MSGFILE" ExitFailure | tee -a $LOGFILE
      exit 1
    fi
    DISPLAYTYPE="HP-UX 11 - aCC Enabled"
  ;;
esac
}

#-------------------------------------------------------------------------------
#  GetMachineType
#    This function sets 4 variables : DISPLAYTYPE (for Solaris and AIX),
#                                     MACHINETYPE, TARXF and TARTF
#  for TARXF use value of toolkit.sh, so it can changed easy
#-------------------------------------------------------------------------------
GetMachineType ()
{
  TARTF="tar -tf"
  UNAME=`uname -s`
  case $UNAME in
    "AIX")
#   Aix starting from AIX 4.3 is supported
    VERSION=`uname -v`
    MINVERSION=`uname -r`
    if [ \( \( "$VERSION" = "4" \) -a \( "$MINVERSION" != "1" \) -a \( "$MINVERSION" != "2" \) \) ]; then
      MACHINETYPE="AIX4"
      DECRYPTPROG="`pwd`/`Ini_Section_ReadKey_ksh install.pi Files enca`"
      DISPLAYTYPE="AIX"
    elif [  \( "$VERSION" = "5" \) -o \( "$VERSION" = "6" \) -o \( "$VERSION" = "7" \) ] ; then
      MACHINETYPE="AIX5"
      DECRYPTPROG="`pwd`/`Ini_Section_ReadKey_ksh install.pi Files enca`"
      DISPLAYTYPE="AIX"
    else
      Ini_Section_ReadMsg $MSGFILE AIXNoSupport | tee -a $LOGFILE
      Ini_Section_ReadMsg "$MSGFILE" ExitFailure | tee -a $LOGFILE
      exit 1
    fi
    ;;
    "HP-UX")
    VERSION=`uname -r | sed 's/\(....\).*/\1/'`

    if [ "$VERSION" = "B.10" ] ; then
#     Check if it is HP-UX 10.0x (not supported).
      if [ "`uname -r | sed 's/\(..\)\(....\).*/\2/'`" = "10.0" ]; then
        Ini_Section_ReadMsg $MSGFILE HPUXNoSupport | tee -a $LOGFILE
        Ini_Section_ReadMsg "$MSGFILE" ExitFailure | tee -a $LOGFILE
        exit 1
      fi
      VERSION=`uname -r`
      if [ "$VERSION" = "B.10.10" ] ; then
        MACHINETYPE="HPUX1010"
        DECRYPTPROG="`pwd`/`Ini_Section_ReadKey_ksh install.pi Files ench`"
          elif [ "$VERSION" = "B.10.20" ] ; then
        MACHINETYPE="HPUX1020"
        DECRYPTPROG="`pwd`/`Ini_Section_ReadKey_ksh install.pi Files ench`"
      fi
    elif [ "$VERSION" = "B.11" ] ; then
      HPARCH=`uname -m`  
      if [ "$HPARCH" = "ia64" ] ; then
        MACHINETYPE="HPUX11ia64"
      else
        MACHINETYPE="HPUX11"
      fi 
      DECRYPTPROG="`pwd`/`Ini_Section_ReadKey_ksh install.pi Files ench`"
    fi
    ;;

    "SunOS")
    VERSION=`uname -r | sed 's/\(.\).*/\1/'`
    if [ "$VERSION" = "5" ] ; then
       processor=`uname -p`
       if [ "$processor" = "i386" ] ; then
         MACHINETYPE="Solarisx86"
         DISPLAYTYPE="Solaris x86"
       else
         MACHINETYPE="Solaris"
         DISPLAYTYPE="Solaris"
      fi
      DECRYPTPROG="`pwd`/`Ini_Section_ReadKey_ksh install.pi Files encs`"
    fi
    ;;

    "Linux")
    VERSION=`uname -r`
    MACHINETYPE="Linux"
    DECRYPTPROG="`pwd`/`Ini_Section_ReadKey_ksh install.pi Files encs`"
    DISPLAYTYPE="Linux"
    ;;

    "NONSTOP_KERNEL")
    VERSION=`uname -r`
    MACHINETYPE="NONSTOP_KERNEL"
    DECRYPTPROG="`pwd`/`Ini_Section_ReadKey_ksh install.pi Files encs`"
    DISPLAYTYPE="NonStop Kernel"
    ;;

    "OS/390")
    VERSION=`uname -r`
    MACHINETYPE="USS"
    DECRYPTPROG="`pwd`/`Ini_Section_ReadKey_ksh install.pi Files encs`"
    DISPLAYTYPE="z/OS Unix System Services"
    ;;

    "UnixWare")
    VERSION=`uname -r`
    MACHINETYPE="UnixWare"
    DECRYPTPROG="`pwd`/`Ini_Section_ReadKey_ksh install.pi Files encs`"
    DISPLAYTYPE="UnixWare"
    ;;

    *)
    ;;
  esac;

  CheckPlatformSupport

  if [ -z "$MACHINETYPE" ] ; then
    clear
    Ini_Section_ReadMsg "$MSGFILE" MachineNotFound | tee -a $LOGFILE
    Ini_Section_ReadMsg "$MSGFILE" ExitFailure | tee -a $LOGFILE
    exit 1
  fi
  return 0;
}

#-------------------------------------------------------------------------------
# CheckAvailSpace
#   Checks the available space in the passed directory and puts it in
#   the AVAILSPACE variable.
# Usage
#   CheckAvailSpace <dirname>
#-------------------------------------------------------------------------------
CheckAvailSpace()
{
  case $MACHINETYPE in
  "AIX" | "AIX5" )
    AVAILSPACE=`eval df -k $1 | sed '1d' 2>> $LOGFILE | awk '{print $3}'`
    return 0
    ;;
  "HPUX1010" | "HPUX1020" | "HPUX11" | "HPUX11ia64" )
    AVAILSPACE=`eval df -b $1 | awk '{i=NF-2 ; print $i}'`
    return 0
    ;;
  "Solaris" | "Solarisx86" )
    AVAILSPACE=`eval df -k $1 | sed '1d' 2>> $LOGFILE | awk '{print $4}'`
    return 0
    ;;
  "LINUX" | "Linux" )
    AVAILSPACE=`eval df -kP $1 | sed '1d' 2>> $LOGFILE | awk '{print $4}'`
    return 0
    ;;
  "NONSTOP_KERNEL")
    AVAILSPACE=100000 # df does not work...
    return 0
    ;;
  "USS")
    AVAILSPACE=`eval df -kP $1 | sed '1d' 2>> $LOGFILE | awk '{print $4}'`
    return 0
    ;;
  "UnixWare")
    AVAILSPACE=`eval df -k $1 | sed '1d' 2>> $LOGFILE | awk '{print $4}'`
    return 0
    ;;
  *)
    Ini_Section_ReadMsg $MSGFILE NoSpace | tee -a $LOGFILE
    Ini_Section_ReadMsg $MSGFILE ExitFailure | tee -a $LOGFILE
    exit 1
  esac;
}

#-------------------------------------------------------------------------------
# CheckUserPermissions
# Usage
#   CheckUserPermissions <dirname>
#-------------------------------------------------------------------------------
CheckUserPermissions()
{
  DIR=$1
  touch $DIR/tmpfile 2> /dev/null
  if [ $? -ne 0 ]; then
    Ini_Section_ReadMsg $MSGFILE ImproperRights
    ERRCHK=1
    return 1
  fi
  rm $DIR/tmpfile
  ERRCHK=0
  return 0
}

#-------------------------------------------------------------------------------
# SetLanguage
#   Sets the language and the path of the message file. sets the following
# variables: DEFLANG, MSGFILE, MSGFILEABS
# Usage:
#   SetLanguage
#-------------------------------------------------------------------------------
SetLanguage()
{
  DEFLANG="`Ini_Section_ListKeys_One $LANGMSG Languages 1`"
  MSGFILE="etc/lang/`Ini_Section_ReadKey_ksh $LANGMSG Languages $DEFLANG`"
  TMPLANG="$DEFLANG"
  if [ ! -z "`Ini_Section_ListKeys_One $LANGMSG Languages 2`" ]
  then
    Ini_Section_ReadMsg $MSGFILE LangBanner
    nRec=1
    while true
    do
      TMPLANG="`Ini_Section_ListKeys_One $LANGMSG Languages $nRec`"
      print -n "$nRec) "
      if [ -z "$TMPLANG" ]
      then
        Ini_Section_ReadMsg $MSGFILE QuitOpt
        break
      else
        print "$TMPLANG"
        nRec=`expr $nRec + 1`
      fi
    done
    Ini_Section_ReadMsg $MSGFILE ProdPrompt
    QueryNum 1 "$nRec"
    if [ "$ANSWER" = "$nRec" ]
    then
      Ini_Section_ReadMsg "$MSGFILE" ExitAbort
      exit 1
    fi
    TMPLANG="`Ini_Section_ListKeys_One $LANGMSG Languages $ANSWER`"
    MSGFILE="etc/lang/`Ini_Section_ReadKey $LANGMSG Languages $TMPLANG`"
    MSGFILEABS=`pwd`/$MSGFILE
  fi
  print
  print -n "$TMPLANG "
  Ini_Section_ReadMsg "$MSGFILE" LangSelected
  MSGFILEABS=`pwd`/$MSGFILE
}

#-------------------------------------------------------------------------------
# CheckDirectory
#   Queries for the directory and checks it correctness w.r.t. the access
#   permissions, existence etc. And returns the directory name in the RET
#   variable.
# Usage:
#   CheckDirectory <dirname> <querymsg>
# Return
#   Puts the return value, i.e. the dir input in the variable RET
#-------------------------------------------------------------------------------
CheckDirectory()
{
  DEFINPDIR="$1"
  REMDIR=

  while true
  do
    clear
    Ini_Section_ReadMsg $MSGFILE DefDir
    print -n "Target directory ? [$DEFINPDIR] : "
    read INPDIR
    if [ "$INPDIR" = "" ]; then
         INPDIR="$DEFINPDIR"
    fi
    BEG="`echo $INPDIR | awk '/^\// {print}'`"
    SPACE="`echo $INPDIR | grep ' '`"
    # Check if the input dir is absolute path. If not give error else
    # continue.
    if [ -z "$BEG" ]; then
      Ini_Section_ReadMsg $MSGFILE NotAbsPath | tee -a $LOGFILE
    # Input dir should not contain spaces.
    elif [ ! -z "$SPACE" ]; then
      Ini_Section_ReadMsg $MSGFILE NoSpacesAllowed | tee -a $LOGFILE
    else
      # Check if the dir exists? If not create it, else check its
      # correctness.
      if [ ! -d $INPDIR ]; then
        CHKDIR="$INPDIR"
        # Find the exact dir that is already existing in the path of the
        # new dir. After that is what is going to be created and should be
        # removed if the installation terminates abnormally or user aborts
        # the installation.
        while true
        do
          DIREXIST="`dirname $CHKDIR`"
          BASEXIST="`basename $CHKDIR`"
          if [ -d $DIREXIST ]; then
            REMDIR="$DIREXIST/$BASEXIST"
            break
          fi
          CHKDIR="$DIREXIST"
        done
        Ini_Section_ReadMsg $MSGFILE MsgCreateDir | tee -a $LOGFILE
        print $INPDIR | tee -a $LOGFILE
        if [ \( "$MACHINETYPE" = "AIX4" \) -o \( "$MACHINETYPE" = "AIX5" \) ]; then
          ERR="`eval mkdir -p $INPDIR 2>&1 >>$LOGFILE | sed '1d' | awk '{print}'`"
        else
          ERR="`eval mkdir -p $INPDIR 2>&1 >>$LOGFILE | awk '{print}'`"
        fi
        if [ ! -z "$ERR" ]; then
          print $ERR | tee -a $LOGFILE
        else
          break
        fi
      else
        # Check if dir is /tmp or /tmp/...
        CHKDIR="`echo $INPDIR | awk -F/ '{print $2}'`"
        if [ "$CHKDIR" = "tmp" ]; then
          break;
        fi
        # Check and resolve links if any.
        ResolveLinks "$INPDIR"
        INPDIR="$RET"
        CheckUserPermissions "$INPDIR"
        if [ $ERRCHK -eq 0 ]; then
          break
        fi
      fi
    fi
    QueryYN_Yes "`Ini_Section_ReadMsg $MSGFILE RetryNewTargetDir`"
    if [ "$ANSWER" = "Y" ]; then
      continue
      print "$2"
      read INPDIR
    elif [ "$ANSWER" = "N" ]; then
      Ini_Section_ReadMsg $MSGFILE ExitAbort | tee -a $LOGFILE
      exit 1
    fi
  done
  RET=$INPDIR
}

#-------------------------------------------------------------------------------
# OAODBC_CreateBackup
#   Create a backup of the existing installation.
# Usage:
#   CreateBackup
#-------------------------------------------------------------------------------
OAODBC_CreateBackup()
{
Log_WriteString $LOGFILE ""
Log_WriteString $LOGFILE "OAODBC_CreateBackup start"

  BKUPDIR="$TARGETDIR/backup"
  BKUPTARFILE="$BKUPDIR/oaodbc`date +%m%d%y`.tar"

  BKUPFILES="custom example include tools odbcinst.ini"
  # check installation lib/lib64
  if [ -d $TARGETDIR/lib ] ; then
    BKUPFILES="$BKUPFILES lib odbc.ini oaodbc.sh oaodbc.csh"
  fi
  if [ -d $TARGETDIR/lib64 ] ; then
    BKUPFILES="$BKUPFILES lib64 odbc64.ini oaodbc64.sh oaodbc64.csh"
  fi

  if [ -d $TARGETDIR/locale ] ; then
    BKUPFILES="$BKUPFILES locale"
  fi
  # on Tandem still using ODBC 4.1 messages
  if [ -d $TARGETDIR/messages ] ; then
    BKUPFILES="$BKUPFILES messages"
  fi

  if [ ! -d "$BKUPDIR" ]; then
    Ini_Section_ReadMsg $MSGFILE MsgCreateDir | tee -a $LOGFILE
    print $BKUPDIR | tee -a $LOGFILE
    mkdir $BKUPDIR
  fi
  eval "(cd $TARGETDIR; $TARCF $BKUPTARFILE $BKUPFILES)"
  ERRCHK="$?"
  if [ $ERRCHK -ne 0 ]; then
    Ini_Section_ReadMsg $MSGFILE TarFileError | tee -a $LOGFILE
    Ini_Section_ReadMsg $MSGFILE ExitFailure | tee -a $LOGFILE
    exit 1
  fi
  Ini_Section_ReadMsg $MSGFILE BkupMsg | tee -a $LOGFILE
  print $BKUPDIR | tee -a $LOGFILE

Log_WriteString $LOGFILE "OAODBC_CreateBackup done"
}

#-------------------------------------------------------------------------------
# OAODBC_PrepareOverWrite
#   prepare overwite of the existing installation.
# Usage:
#   OADOBC_PrepareOverWrite
#-------------------------------------------------------------------------------

OAODBC_PrepareOverWrite()
{
Log_WriteString $LOGFILE ""
Log_WriteString $LOGFILE "OAODBC_PrepareOverWrite start"

DIRLIST="include custom lib lib64 locale messages example tools odbchelp"
for i in $DIRLIST
do
  if [ -d $TARGETDIR/$i ] ; then
    chmod -R u+w $TARGETDIR/$i
  fi
done
chmod -R u+w $TARGETDIR/*.txt

if [ -r "$TARGETDIR/$LICFILENAME" ] ; then
  mv "$TARGETDIR/$LICFILENAME" "$TARGETDIR/$LICFILENAME.$$"
fi

Log_WriteString $LOGFILE "OAODBC_PrepareOverWrite done"
}
#-------------------------------------------------------------------------------
# ResolveLinks
#   Resolves the links of the input directory and returns the absolute
#   path in the RET variable
# Usage:
#   ResolveLinks <dirname>
#-------------------------------------------------------------------------------
ResolveLinks()
{
  INPDIR="$1"
  while true
  do
    if [ `ls -l $INPDIR | grep "^l" | wc -l` -ne 1 ]; then
      break
    fi
    LNKDIR="`ls -l $INPDIR | awk '/^l/ {print $11}'`"
    if [ -z "$LNKDIR" ]; then
      break
    fi
    INPDIR="$LNKDIR"
  done
  RET="$INPDIR"
}

#===============================================================================
# Entry point of the script
#===============================================================================

# Get the command line argument if any
ARGV="$1"

TARCF="tar -cf"

# Setup the traps for various signals
trap 'Ini_Section_ReadMsg $MSGFILE ExitAbort | tee -a $LOGFILE; exit 1' 1
trap 'Ini_Section_ReadMsg $MSGFILE ExitAbort | tee -a $LOGFILE; exit 2' 2
trap 'Ini_Section_ReadMsg $MSGFILE ExitAbort | tee -a $LOGFILE; exit 3' 3
trap 'Ini_Section_ReadMsg $MSGFILE ExitAbort | tee -a $LOGFILE; exit 15' 15

# Initialise the install scripts variables
INSTCFG=./install.pi

LOGFILE=/dev/null
LANGMSG=`pwd`/"`Ini_Section_ReadKey_ksh $INSTCFG Files msg`"
DATFILE=`pwd`/"`Ini_Section_ReadKey_ksh $INSTCFG Files dat`"
Ini_Section_ReadMsg $INSTCFG Startup

# Set the language of instruction for the install
if [ -z "$TMPLANG" ]; then
  SetLanguage
else
  MSGFILE="etc/lang/`Ini_Section_ReadKey_ksh $LANGMSG Languages $TMPLANG`"
  MSGFILEABS=`pwd`/$MSGFILE
fi

Log_Create `Ini_Section_ReadKey_ksh $INSTCFG Files log`
Ini_Section_DoCommand $MSGFILE InitToolkit

# The MachineType is set by the master installer. If not set then
# detect the machine type.
# Get the machine type and os type and verify with the user
#if [ -z "$ARGV" ]; then
#  if [ -z "$MACHINETYPE" ]; then
#    GetMachineType
#  fi
#else
#  MACHINETYPE="$ARGV"
#  DISPLAYTYPE="$ARGV"
#fi

# The MachineType is set by the master installer.
# However, the MachineTypes for HP-UX are different than those provided
# by the master installer. We always provide our own MachineType.
# Get the machine type and os type and verify with the user.
if [ -z "$ARGV" ]; then
  unset MACHINETYPE
  GetMachineType
else
  MACHINETYPE="$ARGV"
  DISPLAYTYPE="$ARGV"
fi

if [ "$MACHINETYPE" = "USS" ] ; then
  echo "tput clear" > clear
  chmod u+x clear
  PATH=`pwd`:$PATH
fi

Log_WriteVar $LOGFILE MACHINETYPE
Log_WriteVar $LOGFILE DISPLAYTYPE

clear
Ini_Section_ReadMsg $MSGFILE StartBanner

# Read the product.dat file and initialize for product installation
# First find the reqd section
nRec=1
while true
do
  OS="`Ini_Section_ListKeys_One $DATFILE \"Operating Systems\" $nRec`"
  if [ -z "$OS" ] ;then
    Ini_Section_ReadMsg $MSGFILE NoProducts | tee -a $LOGFILE
    Ini_Section_ReadMsg $MSGFILE ExitFailure | tee -a $LOGFILE
    exit 1
  elif [ "$OS" = "$MACHINETYPE" ] ;then
    break
  fi
  nRec=`expr $nRec + 1`
done
Log_WriteString $LOGFILE "Operating System is $OS"

# OS found. Get the products for the OS
nRec=1
while true
do
  CLIENT="`Ini_Section_ListKeys_One $DATFILE $OS $nRec`"
  if [ -z "$CLIENT" ]; then
    break
  else
    nRec=`expr $nRec + 1`
  fi
done
if [ $nRec -gt 2 ]; then
  Ini_Section_ReadMsg $MSGFILE ProdBanner
  nItem=1
  while true
  do
    CLIENT="`Ini_Section_ListKeys_One $DATFILE $OS $nItem`"
    print -n "$nItem) "
    if [ -z "$CLIENT" ] ;then
      Ini_Section_ReadMsg $MSGFILE QuitOpt
      break
    fi
    print "$CLIENT"
    nItem=`expr $nItem + 1`
  done
  Ini_Section_ReadMsg $MSGFILE ProdPrompt
  QueryNum 1 "$nItem"
  if [ "$ANSWER" = "$nItem" ]
  then
    Ini_Section_ReadMsg "$MSGFILE" ExitAbort
    exit 1
  fi
else
  ANSWER=1
fi

CLIENT="`Ini_Section_ListKeys_One $DATFILE $OS $ANSWER`"
if [ -z "$CLIENT" ] ;then
  Ini_Section_ReadMsg $MSGFILE NoProducts | tee -a $LOGFILE
  Ini_Section_ReadMsg $MSGFILE ExitFailure | tee -a $LOGFILE
  exit 1
fi

Ini_Section_ReadMsg $MSGFILE PrepareInst | tee -a $LOGFILE
print "OpenAccess SDK Client for ODBC on $DISPLAYTYPE." | tee -a $LOGFILE
QueryYN_Yes "`Ini_Section_ReadMsg $MSGFILE QueryContinue`"
if [ "$ANSWER" = "N" ]; then
  Ini_Section_ReadMsg $MSGFILE ExitAbort | tee -a $LOGFILE
  exit 1
fi

# Check if the 64-bit client needs to be installed
CANINSTALL64BIT="N"
if [ \( "$MACHINETYPE" = "Solaris" \) -o \( "$MACHINETYPE" = "AIX5" \) ] ; then
  CANINSTALL64BIT="Y"
fi
if [ \( "$MACHINETYPE" = "Linux" \) -a \(  `uname -m` = "x86_64" \) ] ; then
  CANINSTALL64BIT="Y"
fi

# Read the client section and initialize vars for install
PRODFILE__="`Ini_Section_ReadKey $DATFILE \"$CLIENT\" ProductFile__`"
PRODFILE32="`Ini_Section_ReadKey $DATFILE \"$CLIENT\" ProductFile32`"
PRODFILE64="`Ini_Section_ReadKey $DATFILE \"$CLIENT\" ProductFile64`"
DEFDIR="${DEFDIR:-`Ini_Section_ReadKey $DATFILE \"$CLIENT\" DefaultDir`}"
SIZEREQ="`Ini_Section_ReadKey $DATFILE \"$CLIENT\" SizeReq`"
DRIVER="`Ini_Section_ReadKey $DATFILE \"$CLIENT\" DriverFile`"
DRIVERDESCR="`Ini_Section_ReadKey $DATFILE \"$CLIENT\" DriverDescr`"
DRIVERTRC="`Ini_Section_ReadKey $DATFILE \"$CLIENT\" DriverTrace`"
DRIVERTRC64="`Ini_Section_ReadKey $DATFILE \"$CLIENT\" DriverTrace64`"

BOOKFILE="etc/tar/odbchelp.tar"

# change tar extract command when installing as non-root
myid=`id|sed -n 's/uid=\([0-9]*\).*/\1/p'`
if [ $myid -ne 0 ] ; then
 TARXF="tar -xf"
fi

# Check for the product tar file so that u can warn the user about
# incomplete installation product.
if [ ! -s $PRODFILE__ ]; then
  Ini_Section_ReadMsg $MSGFILE NoFullInstall | tee -a $LOGFILE
  Ini_Section_ReadMsg $MSGFILE ExitFailure | tee -a $LOGFILE
  exit 1
fi
if [ -s $PRODFILE32 ]; then
  PRODFILEXX="$PRODFILE32"
  LICFILENAME="OAODBC32.LIC"
  MAKELIC="$PWD/makelic"
  INSTALL64BIT="N"
  BUILD=""
elif [ -s $PRODFILE64 ]; then
  PRODFILEXX="$PRODFILE64"
  LICFILENAME="OAODBC64.LIC"
  MAKELIC="$PWD/makelic64"
  INSTALL64BIT="Y"
  BUILD="64"
else
  Ini_Section_ReadMsg $MSGFILE NoFullInstall | tee -a $LOGFILE
  Ini_Section_ReadMsg $MSGFILE ExitFailure | tee -a $LOGFILE
  exit 1
fi


#make full path for tar-file
PRODFILE__="$PWD/$PRODFILE__"
PRODFILEXX="$PWD/$PRODFILEXX"
BOOKFILE="$PWD/$BOOKFILE"
Log_WriteString $LOGFILE "FullPath tar files:"
Log_WriteVar $LOGFILE PRODFILE__
Log_WriteVar $LOGFILE PRODFILEXX
Log_WriteVar $LOGFILE BOOKFILE

if [ "$INST_SHOWEULA" != "NO" ] ; then
  # Query for the license agreement. If user does not agree then show
  # message, remove files from the install and exit
  clear
  QueryLicense
  if [ "$ANSWER" = "N" ]; then
    Ini_Section_ReadMsg $MSGFILE NoAccept | tee -a $LOGFILE
    exit
  fi
fi


# ask/validate TARGETDIR
while : ; do

CheckDirectory "$DEFDIR" "`Ini_Section_ReadMsg $MSGFILE QueryTargetDir`"
TARGETDIR="$RET"
RMTARGETDIR=$REMDIR

Log_WriteString $LOGFILE "installing in $TARGETDIR"

if [ -s "$BOOKFILE" ] ; then
  QueryYN_No "`Ini_Section_ReadMsg $MSGFILE QueryOnlineDocsODBC`"
  BOOKSINSTALL=$ANSWER
fi

# get the size of the input tar files and calculate the size needed
SIZE__=`eval du -k "$PRODFILE__" | awk '{ print $1}'`
SIZEXX=`eval du -k "$PRODFILEXX" | awk '{ print $1}'`
SIZEBK=`eval du -k "$BOOKFILE"   | awk '{ print $1}'`
let SIZEREQ=SIZE__+SIZEXX
if [ "$BOOKSINSTALL" = "Y" ] ; then
  let SIZEREQ=SIZEREQ+SIZEBK
fi
# add 1k for files as odbc.ini and script-files
let SIZEREQ=SIZEREQ+1

CheckAvailSpace $TARGETDIR
Log_WriteVar $LOGFILE BOOKSINSTALL
Log_WriteVar $LOGFILE SIZEREQ
Log_WriteVar $LOGFILE AVAILSPACE

if [ $SIZEREQ -lt $AVAILSPACE ]; then
  Ini_Section_ReadMsg $MSGFILE SpaceOk | tee -a $LOGFILE
else
  Ini_Section_ReadMsg $MSGFILE SpaceFailed | tee -a $LOGFILE
  Ini_Section_ReadMsg $MSGFILE SpaceReq | tee -a $LOGFILE
  print $SIZEREQ | tee -a $LOGFILE
  QueryYN_Yes "`Ini_Section_ReadMsg $MSGFILE RetryNewTargetDir`"
  if [ "$ANSWER"  = "Y" ] ; then
    continue
  fi
  Ini_Section_ReadMsg "$MSGFILE" ExitAbort | tee -a $LOGFILE
  exit 1
fi

# check for existing installations of the product.
if [ -f $TARGETDIR/lib$BUILD/$DRIVER ]; then
  Ini_Section_ReadMsg $MSGFILE AlreadyExists | tee -a $LOGFILE
  QueryYN_No "`Ini_Section_ReadMsg $MSGFILE QueryOverwrite` [N] "
  if [ "$ANSWER" = "Y" ]; then
    QueryYN_Yes "`Ini_Section_ReadMsg $MSGFILE QueryBackup`"
    if [ "$ANSWER" = "Y" ]; then
      OAODBC_CreateBackup
      bBACKUP="True"
    else
      Ini_Section_ReadMsg $MSGFILE OverWriteExisting | tee -a $LOGFILE
    fi
    OAODBC_PrepareOverWrite
    break ; # start install
  else # no overwrite wanted
    QueryYN_Yes "`Ini_Section_ReadMsg $MSGFILE RetryNewTargetDir`"
    if [ "$ANSWER"  = "Y" ] ; then
      continue
    fi
    Ini_Section_ReadMsg "$MSGFILE" ExitAbort | tee -a $LOGFILE
    exit 1
  fi
else
  break ; # start install
fi

done # while 

# Target dir set
if [ ! -d "$TARGETDIR" ]; then
  mkdir -p $TARGETDIR
fi

# Before installing Ask the user for Name, Company Name, Serial number and IPE Key.
GetRegistrationInfo

Ini_Section_ReadMsg $MSGFILE WaitMsg

# start untar PRODFILE__ and PRODFILEXX
eval "(cd $TARGETDIR; $TARXF $PRODFILE__ )"
ERRCHK="$?"
if [ $ERRCHK -eq 0 ]; then
  eval "(cd $TARGETDIR; $TARXF $PRODFILEXX )"
  ERRCHK="$?"
fi
if [ $ERRCHK -ne 0 ]; then
  Ini_Section_ReadMsg $MSGFILE TarFileError | tee -a $LOGFILE
  Ini_Section_ReadMsg $MSGFILE ExitFailure | tee -a $LOGFILE
  if [[ "$bBACKUP" = "True" && -f $BKUPTARFILE ]]; then
    Ini_Section_ReadMsg $MSGFILE RestoreBackup | tee -a $LOGFILE
    print $BKUPDIRTARFILE | tee -a $LOGFILE
  fi
  if [ ! -z "$RMTARGETDIR" ]; then
    rm -rf $RMTARGETDIR
  fi
  exit 1
fi
if [ "$BOOKSINSTALL" = "Y" ] ; then
  # remove previous books if they are there
  if [ -d $TARGETDIR/odbchelp ] ; then		
     eval rm -rf $TARGETDIR/odbchelp
  fi
  (cd $TARGETDIR; $TARXF $BOOKFILE)	
fi


# Change owner and group of installed components to current user and group ID.
# When installing on Solaris as user root, the installed files have
# the same user and group ID as in the tar file.
chown -R `id | sed -ne "s/uid=\([0-9]*\).* gid=\([0-9]*\).*/\1:\2/p"` $TARGETDIR/*

# create the LiCFile
Ini_Section_ReadMsg "$MSGFILEABS" LIC_CreateFile
LICDIR="$TARGETDIR/$LICFILENAME"

OLDPWD="$PWD"
cd $TARGETDIR
CreateLicFile 0
cd "$OLDPWD"

# determinate LIBVAR to be used
case "$MACHINETYPE" in
  "AIX4" )
    LIBVAR="LIBPATH"
    ;;
  "AIX5" )
    LIBVAR="LIBPATH"
    ;;
  "HPUX1010" | "HPUX1020" | "HPUX11" | "HPUX11ia64" )
    LIBVAR="SHLIB_PATH"
    ;;
  "Solaris" | "Solarisx86" )
    LIBVAR="LD_LIBRARY_PATH"
    ;;
  "Linux" )
    LIBVAR="LD_LIBRARY_PATH"
    ;;
  "USS" )
    LIBVAR="LIBPATH"
    ;;
  "UnixWare" )
    LIBVAR="LD_LIBRARY_PATH"
    ;;
esac

# preparing to use OAODBC_ConfiG_xxx
LIBPATHKEY="$LIBVAR"
DRIVERFILE="$DRIVER"

LIBROOT="$TARGETDIR/lib${BUILD}"

# Write the template ODBC.INI and ODBCINST.INI file
OAODBC_Config_ODBCINI
OAODBC_Config_ODBCINST
# Write the csh and sh scripts for setting up the env for the example program
OAODBC_Config_CshEnvFile
OAODBC_Config_kshEnvFile
# custom sub dir
OAODBC_Config_Custom
OAODBC_Config_Branding
OAODBC_Config_CUSTOM_MESSAGES

if [ "$INSTALL64BIT" = "Y" ]; then
 Ini_Section_ReadMsg $MSGFILE GoodByeMessageOA64
else
 Ini_Section_ReadMsg $MSGFILE GoodByeMessageOA32
fi

#   Clean up all the unwanted files.
if [ "$MACHINETYPE" = "USS" ] ; then
  rm -f clear
fi

Ini_Section_ReadMsg $MSGFILE InstallSuccess | tee -a $LOGFILE

#

