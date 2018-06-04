import subprocess
import sys
import string
import os

def start_carbon_cache_instance(name):
	path = os.path.realpath(__file__)
	subprocess.call(["python", "{0}/bg-carbon-cache".format(os.path.dirname(path)), "--instance={0}".format(name), "start"])


def stop_carbon_cache_instance(name):
	path = os.path.realpath(__file__)
	subprocess.call(["python", "{0}/bg-carbon-cache".format(os.path.dirname(path)), "--instance={0}".format(name), "stop"])	


def usage():
	print("carbon_cache [start/stop] [instance name type: letter or number] [number of instances]")
	print("instance names should be continuous")
	print("For example: 1, 2, 3,... or a, b, c,...")
	print("Usage: python carbon_cache start n 5")


def main():
	if len(sys.argv) < 4:
		print("Too few arguments")
		usage()
		return
	if len(sys.argv) > 4:
		print("Too many arguments")
		usage()
		return
	if sys.argv[1] not in ['start', 'stop']:
		print("Wrong operation! start or stop only!")
		return;
	if sys.argv[2] not in ['n', 'l']:
		print("Wrong Type! l or n only!")
		return

	num = int(sys.argv[3])


	if sys.argv[1] == 'start':
		func = start_carbon_cache_instance
	else:
		func = stop_carbon_cache_instance

	if sys.argv[2] == 'n':
		for i in range(num):
			func(i + 1)
	else:
		li = list(string.ascii_lowercase)[:num]
		for i in li:
			func(i)


if __name__ == '__main__':
	main()
