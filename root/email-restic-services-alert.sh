#!/bin/sh

# email-send.sh args:
# - source name
# - dest name <dest email>
# - subject line
# - extra headers
# - message body

safecat() {
	[ -f "$1" ] && cat "$1"
}

./email-send.sh \
	'Michiru Restic Alerts' \
	'Hazel Atkinson <yellowsink@riseup.net>' \
	'**ERROR** Restic Failure Report' \
	'Content-Type: text/html; charset=ISO-8859-1' \
	"<h1>Restic Failure Report</h1>
	
	<p>The scheduled Restic backup run <strong><span style='color: red'>failed</span></strong>.
	<p>The contents of the status file are:</p>
	
	<code>
	<pre>
	$(safecat services-status.json)
	</pre>
	</code>
	
	<p>And the contents of the log file are:</p>
	
	<code>
	<pre>
	$(safecat resticprofile-schedule-services.log)
	</pre>
	</code>

	<p>Due to the failure, the docker containers have not been restarted.</p>

	<p>This email was automatically generated at $(date) by <i>Hazel's magic email scripts:tm:</i> on <a href="https://michiru.yellows.ink">Michiru</a>.</p>"
