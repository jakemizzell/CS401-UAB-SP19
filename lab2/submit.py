#!/usr/bin/python3
#
# Autograder Copyright (c) Tom Gilray, Kris Micinski
# All right reserved
# DO NOT SHARE WITHOUT WRITTEN PERMISSION OF THE AUTHORS.
#
# The global submit script for all class projects.
import requests
import traceback
import sys
import subprocess
import tempfile
import time
import datetime
import os
from argparse import ArgumentParser
from PyInquirer import *
from colorama import Fore
from colorama import Style
from prettytable import PrettyTable

#------------------------------------------------------
# CONFIGURATION
#------------------------------------------------------

# How to call python on your system. Usually `python3`, but might just be
# `python` or even something like `python3.7`
PYTHON = "python3"

#------------------------------------------------------
# END CONFIGURATION
#------------------------------------------------------

password = None
server = "https://submit.gilray.net"


topText = """
   _____       __              __ __
  / ___/__  __/ /_  ____ ___  /_/ /_
  \__ \/ / / / __ \/ __ `__ \/ / __/
 ___/ / /_/ / /_/ / / / / / / / /_
/____/\____/_____/_/ /_/ /_/_/\__/   (by Kris+Tom)
"""

style = style_from_dict({
    Token.Separator: '#6C6C6C',
    Token.QuestionMark: '#FF9D00 bold',
    #Token.Selected: '',  # default
    Token.Selected: '#5F819D',
    Token.Pointer: '#FF9D00 bold',
    Token.Instruction: '',  # default
    Token.Answer: '#5F819D bold',
    Token.Question: '',
})

def error(str):
    print(f"{Fore.RED}" + str + f"{Style.RESET_ALL}")
    sys.exit(1)

def no_connection():
    print(f"{Fore.RED}>>> Failed to communicate with submit server. Is your internet working? <<<{Style.RESET_ALL}")
    os._exit(1)

def exeunsafe(str):
    print(f'Executing {str}')
    try:
        x = subprocess.check_output(str,stderr=subprocess.STDOUT,shell=True)
    except:
        error("The previous command failed. Please run it yourself an install the necessary software if needed.")
    return x

def getFolderName():
    return os.path.basename(os.path.dirname(os.path.realpath(__file__)))

class BadResultException(Exception):
    pass

class NoConnection(Exception):
    pass

class Command:
    def __init__(self):
        creds = []
        try:
            creds = open("credentials").read().split('|')
        except:
            error("Your credentials file either does not exist or is malformed")
        self.username = creds[0].strip()
        self.password = creds[1].strip()

    def buildPacket(self, json):
        data = {}
        data.update({'username': self.username,
                     'password': self.password})
        data.update(json)
        return data

    def rawget(self,json):
        try:
            return requests.get(server,json=json)
        except:
            no_connection()

    def get(self,json):
        r = self.rawget(json)
        if (r.status_code != 200):
            error("Server returned an error. Please contact your TA or Professor.")
            try: error(r.json()['error'])
            except: pass
        return r

    def getJson(self,json):
        return self.get(json).json()

    def post(self,json):
        try:
            r = requests.post(server,json=json)
            if (r.status_code != 200):
                error("Server returned an error. Please contact your TA or Professor.")
            return r
        except:
            network_error()

    def sendFile(self,json,filename):
        fname = open(os.path.join(os.path.dirname(__file__), filename), 'rb')
        files = {'file': fname}
        try:
            return requests.post(server,files=files,data=json)
        except:
            network_error()

    def tarCurDir(self):
        to = tempfile.mkstemp()[1] + ".tar.gz"
        exeunsafe(f"tar -czf {to} .")
        return to

    def submit(self):
        maxsize = 2097152
        tarFile = self.tarCurDir()
        if (os.path.getsize(tarFile) > maxsize):
            error("File size too large. You cannot submit folders >2MB.")
        json = self.buildPacket(self.command('submit'))
        json.update({'project':getFolderName()})
        return self.sendFile(json, tarFile)

    def command(self, action):
        return {"action": action}

    def getSubmissions(self):
        cmd = self.buildPacket(self.command('view_submissions'))
        cmd.update({'project':getFolderName()})
        return self.getJson(cmd)

    def getResults(self, sid):
        c = self.command('view_results')
        c.update({'sid': sid})
        cmd = self.buildPacket(c)
        return self.getJson(cmd)

    def getAssignments(self):
        cmd = self.buildPacket(self.command('view_assignments'))
        return self.getJson(cmd)

    def getStatus(self):
        c = self.command('get_status')
        c.update({'pid': getFolderName()})
        cmd = self.buildPacket(c)
        return self.getJson(cmd)

    def getAssignment(self,asn,filename):
        cmd = self.command('get_starter')
        cmd.update({'assignment':asn})
        cmd = self.buildPacket(cmd)
        result = self.get(cmd)
        f = open(filename, 'wb')
        f.write(result.content)
        f.close()

    def getTokens(self):
        r = self.get(self.buildPacket(self.command('get_tokens')))
        return r.json()['tokens']

    def getGrades(self):
        r = self.get(self.buildPacket(self.command('get_grades')))
        return r.json()['grades']

    def verifyLogin(self):
        r = self.rawget(self.buildPacket(self.command('check_student_login')))
        return r.status_code == 200

parser = ArgumentParser(description="Submit and manage assignment submissions, grades, etc...")
subparsers = parser.add_subparsers()

#parser_init = subparsers.add_subparser('init')
#parser_init.set_defaults(func=init)

def needs_init():
    try:
        return len(open("credentials").read().split('|')) != 3
    except:
        return True

# Messages
confirmInit = {'type':'confirm',
               'name':'doInit',
               'message':'This directory is empty, would you like to initialize a new project?'}

confirmSubmit = {'type':'confirm',
                 'name':'doSubmit',
                 'message':'Would you like to submit your assignment for grading?'}

initQuestions = [{'type': 'input',
                  'name': 'username',
                  'message': 'What is your username?'},
                 {'type': 'password',
                  'name': 'password',
                  'message': 'What is your password?'}]

mainPrompt = [{
    'type': 'list',
    'name': 'choice',
    'message': 'What do you want to do?',
    'choices': [
        {'name':'Get Project Status and Deadline','value':'get_status'},
        {'name':'Run Tests Locally','value':'test'},
        {'name':'Submit for Remote Testing','value':'submit'},
        {'name':'View Results of Submitted Assignments','value':'viewsubs'},
        {'name':'Check Your Grades', 'value':'viewgrades'},
        Separator(),
        {'name':'Exit to Command Line', 'value':'exit'}
    ]}]

# Set up the project
def setup():
    cmd = None
    print(f"""{Fore.YELLOW}>>> Initializing `credentials` and `.gitignore` files <<<{Style.RESET_ALL}

    {Fore.GREEN}Note{Style.RESET_ALL}: it is very important that you do not do not
    distribute the `credentials` file. It stores your username and
    password. Please avoid sending it to anyone (doing so will be
    considered a violation of the honor code) or checking it into
    git.""")
    while (True):
        answers = prompt(initQuestions, style=style)
        uname = answers['username']
        pw = answers['password']
        try:
            os.remove("credentials")
        except:
            pass
        print("Verifying password...")
        with open("credentials", "w") as f:
            f.write(f'{uname}|{pw}\n')
        cmd = Command()
        if (cmd.verifyLogin()):
            break
        else:
            os.remove("credentials")
            print(f"{Fore.RED}ERROR: Bad username or password.{Style.RESET_ALL}! Try again..")
    print(f"{Fore.GREEN}>>> Login successful! <<<{Style.RESET_ALL}")
    print("Downloading available projects...")
    assignments = cmd.getAssignments()['assignments']
    print(f"""{Fore.YELLOW}>>> Here are the available projects for your course <<<{Style.RESET_ALL}

    You must select the project whose shortname is the same as the
    name of this directory. If you want to work on a project not
    listed here (e.g., `proj0`), you must crate an empty directory
    with that name and run `submit.py` from that directory.""")
    choices = []
    names = []
    for assignment in assignments:
        choices.append({'name':f"({assignment['name']}) {assignment['pretty']}",
                        'value':assignment['name'],
                        'short':assignment['name']})
        names.append(assignment['name'])
    if (len(choices) == 0):
        print(f"{Fore.YELLOW}>>> No available projects yet, check with your instructor. <<<{Style.RESET_ALL}")
        return
    question = [{
        'type': 'list',
        'name': 'choice',
        'message': 'Here are the available assignments, confirm you will select the current one:',
        'choices': choices,
        'default': getFolderName()}]
    answer = prompt(question,style=style)
    if (not (getFolderName() in names)):
        error(f"Error! Current folder name does not match any available projects!")
    if ((getFolderName() != answer['choice'])):
        error(f"Error! Selected choice {answer['choice']} does not match current folder name {getFolderName()}. See note above.")
    print(f"{Fore.GREEN}>>> Downloading starter files... <<<{Style.RESET_ALL}")
    asn = answer['choice']
    try:
        cmd.getAssignment(asn,"starter.tar.gz")
        print(f"{Fore.GREEN}>>> Unpacking starter files... <<<{Style.RESET_ALL}")
        exeunsafe("tar xvvf starter.tar.gz; rm starter.tar.gz")
        with open("credentials", "w") as f:
            f.write(f'{uname}|{pw}|{getFolderName()}\n')
        with open(".gitignore", "w") as f:
            f.write('credentials\n*~\n*#\nsubmit.py\n')
        print(f"""{Fore.GREEN}🎉🎉🎉 Starter files now ready! 🎉🎉🎉{Style.RESET_ALL}

     You are now all set up. We also recommend creating a (private) git
     repository so that you can periodically save your work. To do this,
     follow the following steps:
     (0) Exit to the command line
     (1) Initialize a git repo
         git init .
     (2) Add all of the current files
         git add .
     (3) Make your first commit
         git commit -m "First commit."
     (4) Create a new private repository on GitHub: log in, click the + sign on
     the top right, select `New Repository`, and follow the steps to create a
     new repository with the name {getFolderName()} (or any other name you
     prefer). Ensure you make it a {Fore.YELLOW}🔒 Private{Style.RESET_ALL} repository and do not initialize
     with a readme.
     (5) Follow the steps to push this repository to github:
         # Ensure you replace with your username and whatever you named your repo
         git remote add origin https://github.com/<your-username>/{getFolderName()}.git
         git push -u origin master
 """)
    except:
        traceback.print_exc()
        error(f"Error! Could not download starter files.")

def submit(cmd):
    tokens = cmd.getTokens()
    if (tokens < 1):
        print(f"{Fore.RED}😔 You have no tokens left! You get one every day at 5:30AM (US Central), with a maximum of 4 tokens. {Style.RESET_ALL}")
        return
    if (tokens == 1):
        print(f"""{Fore.YELLOW}⚠️   WARNING   ⚠️{Style.RESET_ALL}

    You only have one token left. You {Fore.RED}will not{Style.RESET_ALL} be able to submit
    again until tomorrow morning, {Fore.RED}even{Style.RESET_ALL} if this is your final submission
    for the project.
""")
    print(f"""{Fore.CYAN}>>> You have {tokens} tokens left<<<{Style.RESET_ALL}

    Submitting your assignment for remote grading will use up one
    token. You get one token every morning, and can store a maximum of
    4 tokens.  """)
    yn = prompt([confirmSubmit], style=style)
    if yn['doSubmit'] == False:
        print("Okay, not submitting assignment.\n")
        return
    print(f"{Fore.CYAN}>>> Packaging up assignment for submission <<<{Style.RESET_ALL}")
    if (cmd.submit().status_code != 200):
        error(">>> Error! Uploading assignment failed. <<<")
    else:
        print(f"{Fore.GREEN}>>> Assignment submitted. Check back in 5-20 minutes. <<<{Style.RESET_ALL}")

def status(code, num):
    if code == 1:
        return "Graded, %3.2f%%" % (num / 1000)
    else:
        return "Pending"


def latestatus(num):
    if num == 0:
        return "on time"
    elif num == 1:
        return "late"
    elif num == 2:
        return "VERY late"

def testresult(status):
    if status == 0:
        return f"{Fore.GREEN}PASSED{Style.RESET_ALL}"
    elif status == 1:
        return f"{Fore.RED}FAILED{Style.RESET_ALL}"
    elif status == 2:
        return f"{Fore.YELLOW}TIMED OUT{Style.RESET_ALL}"

def view_submissions(cmd):
    submissions = cmd.getSubmissions()
    choices = []
    available = {}
    for submission in submissions:
        month = submission['month']
        day = submission['day']
        year = submission['year']
        hour = submission['hour']
        min = submission['min']
        stat = status(submission['status'],submission['points'])
        sid = submission['sid']
        available[sid] = (submission['status'] == 1)
        ls = latestatus(submission['latestatus'])
        name = f"{sid} ({stat}) {ls} submission on {month}/{day}/{year} at {hour}:{min}"
        choices.append({'name': name, 'value': sid})
    question = [{
        'type': 'list',
        'name': 'choice',
        'message': 'Select a submission to view test results:',
        'choices': choices}]
    if (choices == []):
        print(f'>>> No active submissions at this time, submit via main menu <<<')
        return
    answer = prompt(question,style=style)
    if (not available[answer['choice']]):
        print(f"{Fore.YELLOW}>>> Submission {answer['choice']} is currently being graded <<<{Style.RESET_ALL}")
        return
    print(f"{Fore.GREEN}>>> Retrieving results for tests of submission {answer['choice']} <<<{Style.RESET_ALL}")
    sid = answer['choice']
    results = cmd.getResults(sid)
    if (len(results) < 1):
        error(f"Server returned bad results for submission {sid}")
    if results['latestatus'] == 0:
        print(f"Submission {sid} was {Fore.GREEN}on time{Style.RESET_ALL}.")
    elif results['latestatus'] == 1:
        print(f"Submission {sid} was {Fore.YELLOW}LATE{Style.RESET_ALL}.")
    elif results['latestatus'] == 2:
        print(f"Submission {sid} was {Fore.RED}VERY late{Style.RESET_ALL}.")
    points = results['points']
    testresults = results['results']
    total = len(testresults)
    passed = len(list(filter(lambda r: r['result'] == 0, testresults)))
    timedout = len(list(filter(lambda r: r['result'] == 2, testresults)))
    failed = len(list(filter(lambda r: r['result'] == 1, testresults)))
    print(f"{Fore.CYAN}Total Grade: %3.2f%%.{Style.RESET_ALL} %d/%d Tests {Fore.GREEN}PASSED{Style.RESET_ALL} %d/%d Tests {Fore.YELLOW}TIMED OUT{Style.RESET_ALL} %d/%d Tests {Fore.RED}FAILED{Style.RESET_ALL}" % ((points / 1000), passed, total, timedout, total, failed, total))
    print("")
    h1 = f"{Fore.CYAN}Test Name{Style.RESET_ALL}"
    h2 = f"{Fore.CYAN}Result{Style.RESET_ALL}"
    t = PrettyTable([h1, h2])
    t.align[h1] = "l"
    t.align[h2] = "r"
    # TODO: Fix formatting
    for result in testresults:
        t.add_row([result['testname'], testresult(result['result'])])
    print(t)
    print("\n")

def view_grades(cmd):
    print(f"{Fore.GREEN}>>> Retrieving all of your grades <<<{Style.RESET_ALL}")
    grades = cmd.getGrades()
    h1 = f"{Fore.BLUE}Assignment{Style.RESET_ALL}"
    h2 = f"{Fore.BLUE}Best Grade{Style.RESET_ALL}"
    t = PrettyTable([h1, h2])
    t.align[h1] = "l"
    t.align[h2] = "r"
    # TODO: Fix formatting
    for grade in grades:
        t.add_row([grade['assignment'], "%3.2f%%" % (grade['grade']/1000)])
    print(f"\n{t}\n")

def print_status(cmd):
    try:
        status = cmd.getStatus()
        pretty = status['pretty']
        duemonth = status['duemonth']
        dueday   = status['dueday']
        dueyear  = status['dueyear']
        print(f"{Fore.CYAN}{getFolderName()} -- {pretty}{Style.RESET_ALL}")
        print(f"{Fore.CYAN}>>> 🕛🕛  Project Due at Midnight on {duemonth}/{dueday}/{dueyear} 🕛🕛 <<<{Style.RESET_ALL}")
        nt = datetime.datetime.now()
        year = nt.year
        month = nt.month
        day = nt.day
        due = datetime.datetime.strptime(f"{dueday}/{duemonth}/{dueyear}", "%d/%m/%Y")
        today  = datetime.datetime.strptime(f"{day}/{month}/{year}", "%d/%m/%Y")
        if (due > today):
            leftdays  = (due - today).days
            s = ""
            if leftdays>1: s = "s"
            print(f"{Fore.GREEN}Project on time, you have {leftdays} day{s} left.{Style.RESET_ALL}\n")
        elif (due == today):
            print(f"{Fore.YELLOW}Project is due at MIDNIGHT TODAY.{Style.RESET_ALL}\n")
        elif (due < today and (today - due).days <= 2):
            print(f"{Fore.RED}Project is LATE. Submissions will incur 15% penalty.{Style.RESET_ALL}\n")
        else:
            print(f"{Fore.RED}Project is VERY LATE. Submissions will incur 30% penalty.{Style.RESET_ALL}\n")
    except:
        traceback.print_exc()
        error("Error! Could not look up project status. Make sure your credentials are valid and this folder has not been renamed.")

def get_tests():
    cmd = f"{PYTHON} test.py list"
    process = subprocess.Popen(cmd, shell=True,
                               stdout=subprocess.PIPE,
                               stderr=subprocess.PIPE)
    out, err = process.communicate()
    if (process.returncode != 0):
        error("Could not run test.py. Make sure PYTHON is set at top of submit.py")
    tests = list(map((lambda x: x.strip()), out.decode("utf-8").split(',')))
    return tests

def run_test(test):
    cmd = f"{PYTHON} test.py {test}"
    process = subprocess.Popen(cmd, shell=True,
                               stdout=subprocess.PIPE,
                               stderr=subprocess.PIPE)
    print(f"{Fore.CYAN}>>> Running test {test} <<<{Style.RESET_ALL}")
    out, err = process.communicate()
    print(out.decode("utf-8"))
    if (process.returncode != 0):
        print(f"{Fore.RED}>>> FAILED / TIMEOUT <<<")
        return False
    else:
        print(f"{Fore.GREEN}>>> PASSED <<<")
        return True

def test(cmd):
    # Query the test script
    tests = get_tests()
    options = []
    for test in tests:
        options.append({'name':test, 'value': test, 'checked':True})
    question = [
        {'type': 'checkbox',
         'message': "Select which tests to run (Press ⏎ (enter) when done.)",
         'name': 'tests',
         'choices':options
        }]
    answers = prompt(question, style=style)
    total = 0
    passed = 0
    for test in answers['tests']:
        r = run_test(test)
        total += 1
        if r:
            passed += 1
    print(f"{Fore.CYAN}>>> All tests completed <<<{Style.RESET_ALL}")
    print(f"Summary: {passed}/{total} tests {Fore.GREEN}PASSED{Style.RESET_ALL} {total-passed}/{total} tests {Fore.RED}FAILED (or timed out){Style.RESET_ALL}")

handlers = {'exit': (lambda _: sys.exit(1)),
            'setup': setup,
            'submit': submit,
            'viewgrades': view_grades,
            'get_status': print_status,
            'test': test,
            'viewsubs': view_submissions}

def main():
    print(topText)
    if needs_init():
        yn = prompt([confirmInit], style=style)
        if yn['doInit'] == False:
            sys.exit(0)
        setup()
    cmd = Command()
    print_status(cmd)
    while(True):
        answer = prompt(mainPrompt, style=style)
        handlers[answer['choice']](cmd)

debug = False

try:
    main()
except SystemExit:
    print("Now exiting autograder.")
except:
    if debug:
        traceback.print_exc()
    print("Now exiting autograder.")

