#!/usr/bin/env sh

if [ -n "$DEBUG" ]; then
    echo "DEBUG: $0"
fi

app_home=""
[ -n "$APP_HOME" ] && app_home="$APP_HOME"

if [ -z "$app_home" ]; then
    case $0 in
        /* | ?:*) app_home=`dirname "$0"` ;;
        *) app_home=`dirname "`pwd`/$0"` ;;
    esac
fi

EXEC="exec"
BASENAME=`basename "$0"`

if [ -n "$JAVA_HOME" ] ; then
    if [ -x "$JAVA_HOME/jre/sh/java" ] ; then
        JAVACMD="$JAVA_HOME/jre/sh/java"
    else
        JAVACMD="$JAVA_HOME/bin/java"
    fi
    if [ ! -x "$JAVACMD" ] ; then
        echo "ERROR: JAVA_HOME is set to an invalid directory: $JAVA_HOME" >&2
        exit 1
    fi
else
    JAVACMD="java"
    which java >/dev/null 2>&1 || {
        echo "ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH." >&2
        exit 1
    }
fi

DEFAULT_JVM_OPTS='"-Xmx64m" "-Xms64m"'
JAVA_OPTS="$JAVA_OPTS -XX:+UseContainerSupport"

exec "$JAVACMD" $JAVA_OPTS \
    -classpath "$app_home/gradle/wrapper/gradle-wrapper.jar" \
    org.gradle.wrapper.GradleWrapperMain "$@"
