#!/usr/bin/env python
import argparse
from os import path
import sys


def execute(input, output, separator):
    with open(input, 'r') as f_source:
        lines = f_source.readlines()

    with open(output, 'w') as f_target:
        for line in lines:
            field_1 = path.dirname(line.replace('\\', '/')).replace('/', '\\')
            field_2 = path.basename(line.replace('\\', '/')).replace('/', '\\')
            output = '%(field1)s%(separator)s%(field2)s' % {
                    'field1': field_1,
                    'separator': separator,
                    'field2': field_2,
                    }
            f_target.write(output)


def main(args):
    parser = argparse.ArgumentParser()
    parser.add_argument("-i", "--input", type=str,
                        help="ruta archivo origen")
    parser.add_argument("-o", "--output", type=str,
                        help="ruta archivo destino")
    parser.add_argument("-s", "--separator", type=str,
                        choices=[',', ';', '|', ' '],
                        help="caracter separador")

    args = parser.parse_args()
    if not args.input or not args.output or not args.separator:
        print "Faltan argumentos!"
        sys.exit(1)
    if not path.exists(args.input):
        print "Ruta incorrecta al archivo origen!"
        sys.exit(1)
    if not args.output:
        print "Falta la ruta al archivo destino!"
        sys.exit(1)
    if not args.separator:
        print "Falta especificar caracter separador!"
        sys.exit(1)

    execute(args.input, args.output, args.separator)


if __name__ == '__main__':
    main(sys.argv)
