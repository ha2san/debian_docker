import os
import subprocess
import argparse

def assemble(filename, outfile):
    size = os.stat(filename).st_size
    f = open(filename, 'r')
    f.seek(max(0, size - 4096)) # we store metadata only at the end
                        # no need to read the whole file
    deps, secs = [], {}
    last_lines = f.readlines()
    for line in last_lines:
        if "DEPENDENCY:" in line:
            deps += [line.split(": ")[1]]
        if "SECTION:" in line:
            name, addr = line.split(": ")[1].split(" - ")
            secs[name] = addr.strip()

    print("Will link with the following dependencies:")
    print("".join(deps))

    print("Will link with the following sections:")
    print(secs)

    lflags = []
    for d in deps:
        if "ld-linux" in d: continue
        dep = "-l:" + d.strip()
        lflags += [dep]
    lflags = " ".join(lflags)

    wlflags = []
    for sec, addr in secs.items():
        wlflags += ["--section-start="+sec+"="+addr]
    wlflags = "-Wl," + ",".join(wlflags)
    #wlflags += " -march=armv8.1-a+crc+crypto+sve"
    # wlflags += ",--no-check-sections"

    pie = "-no-pie" if any("NOPIE" in x for x in last_lines) else "-pie"

    print("Assembling...")
    asmline = f"clang++ {filename}  {pie} -nostartfiles {lflags} {wlflags} -o {outfile}"
    print(asmline)
    subprocess.check_output(asmline, shell=True) 

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="Reassemble")
    parser.add_argument("bin", type=str, help="Input ASM to load")
    parser.add_argument("outfile", type=str, help="output binary")
    args = parser.parse_args()
    assemble(args.bin,args.outfile)

