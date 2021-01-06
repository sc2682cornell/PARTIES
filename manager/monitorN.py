import os;
import sys;
import subprocess;
import time;
import threading;


DIR = "/home/sc2682/scripts/monitor"
PROF_PATH = "/home/sc2682/tools/intel-cmt-cat/pqos"

def startMonitoring(TIME):
    global DIR, PROF_PATH
    endMonitoring()
    
    cacheout = open("%s/cat.txt" % DIR, "w")
    cpuout = open("%s/cpu.txt" % DIR, "w")
    FREQ = 1 # frequency of monitoring
    if TIME == -1:
        cacheproc = subprocess.Popen("taskset -c 0 %s/pqos -i %d -m \"all:0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21\" " % (PROF_PATH, FREQ), shell=True, stdout=cacheout, stderr=cacheout, preexec_fn=os.setsid,bufsize=0);
        cpuproc = subprocess.Popen("taskset -c 1 mpstat -P 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21 1", shell=True, stdout=cpuout, stderr=cpuout, preexec_fn=os.setsid);
    else:
        cacheproc = subprocess.Popen("taskset -c 0 %s/pqos -i %d -m \"all:0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21\" -t %d" % (PROF_PATH, FREQ, TIME), shell=True, stdout=cacheout, stderr=cacheout, preexec_fn=os.setsid,bufsize=0);
        cpuproc = subprocess.Popen("taskset -c 1 mpstat -P 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21 1 %d" % TIME, shell=True, stdout=cpuout, stderr=cpuout, preexec_fn=os.setsid);
        cacheproc.wait();
        cpuproc.wait();
        cacheout.close()
        cpuout.close()

def endMonitoring():
    global PROF_PATH

    os.system("killall pqos")
    os.system("killall mpstat")
    PROF_RESET = "%s/pqos -r -t 1" % PROF_PATH
    tmp_file = open("tmp", "w");
    prof = subprocess.Popen("%s" % PROF_RESET, shell=True, stdout=tmp_file, stderr=tmp_file, preexec_fn=os.setsid);
    prof.wait();
    tmp_file.close();

TT = -1
if len(sys.argv) > 1:
    TT = int(sys.argv[1])
startMonitoring(TT)


    
