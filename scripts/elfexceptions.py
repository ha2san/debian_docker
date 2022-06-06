#!/usr/bin/env python3

import sys
from elftools.elf.elffile import ELFFile
from elftools.elf.relocation import RelocationSection


def process_file(fname):
    with open(fname, 'rb') as f:
        f.seek(0)
        if f.read(4) != b"\x7fELF":#Are you an elf ? 
            f.seek(0)
            print("This is not an elf file")
            return
        f.seek(0)

        e = ELFFile(f)
        section = e.get_section_by_name(".rela.plt")
        #for section in e.iter_sections():
        if not isinstance(section, RelocationSection):
            return False 
        symbol_table = e.get_section(section['sh_link'])
        for relocation in section.iter_relocations():
            symbol = symbol_table.get_symbol(relocation['r_info_sym'])
            if(symbol.name == "__cxa_allocate_exception"):
                #print("youpi found:",symbol.name)
                return True


if __name__ == '__main__':
    if len(sys.argv) == 2:
        if process_file(sys.argv[1]):
            print("yes")
        else:
            print("no")
