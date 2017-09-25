export SPARK_HOME="/usr/local/Cellar/apache-spark/1.6.1/libexec"
export PYSPARKPATH="$SPARK_HOME/python"
# for Spark 1.4
#export PY4JPATH="$PYSPARKPATH/lib/py4j-0.8.2.1-src.zip"
# for Spark 1.6
export PY4JPATH="$PYSPARKPATH/lib/py4j-0.9-src.zip"
export PYTHONPATH="$PY4JPATH:$PYSPARKPATH:$PYTHONPATH"
export MASTER="local"
