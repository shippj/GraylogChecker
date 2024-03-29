# GraylogChecker
This is a powershell script that periodically checks Graylog for CMMC / NIST SP 800-171 3.3.4 purposes

NIST SP 800-171 3.3.4 is "Alert in the event of an audit logging process failure"

You can run this script from windows task scheduler daily and it will query your graylog server for a message count for the past 24 hours.  If the server responds with 0, responds with an error, or doesn't respond at all, the script will send an email alert.

Special thanks to Graylog staff Joel Duffield for giving me the help I needed to get this done.
