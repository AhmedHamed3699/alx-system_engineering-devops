## Incident Report (Postmortem)

### Issue Summary

    Duration of the Outage: June 25, 2024, from 14:00 to 15:00 UTC
    Impact: The web server was experiencing a high failure rate, with 47.15% of the requests failing. This resulted in significant slowdowns and unavailability for users accessing our services.
    Root Cause: The root cause of the issue was the system's file descriptor limit (ULIMIT) being too low, which restricted the number of concurrent connections the server could handle.

### Timeline

    14:00 UTC: Issue detected via monitoring alert indicating a high failure rate in HTTP requests.
    14:05 UTC: Initial investigation by the on-call engineer revealed a significant number of failed requests in ApacheBench test results.
    14:10 UTC: Investigated server logs for potential application-level errors or Nginx misconfigurations.
    14:20 UTC: Misleading path: Checked for possible network issues or DDoS attacks.
    14:30 UTC: Incident escalated to the senior DevOps engineer for further analysis.
    14:40 UTC: Identified the ULIMIT as a potential bottleneck after ruling out other causes.
    14:50 UTC: Increased the ULIMIT to allow more file descriptors.
    15:00 UTC: Issue resolved; all requests processed successfully, no further failures detected.

### Root Cause and Resolution

    Root Cause: The primary issue was the server's ULIMIT for file descriptors being set too low. This limit controls the number of files (including network sockets) a process can open simultaneously. Given the high number of concurrent requests (2000 with 100 at a time), the server quickly exhausted its available file descriptors, leading to failed connections.
    Resolution: The issue was resolved by increasing the ULIMIT. This adjustment allowed the Nginx server to handle a higher number of concurrent connections without running into the file descriptor limit.

### Corrective and Preventative Measures

    Improvements/Fixes:
        Increase the default ULIMIT for file descriptors on all web servers to handle peak traffic.
        Implement better monitoring to alert for high file descriptor usage before it becomes an issue.
        Conduct regular load testing to ensure server configurations can handle expected traffic volumes.
    Task List:
        Increase ULIMIT: Update the server configuration to set a higher file descriptor limit.
        Monitoring Enhancements: Add metrics and alerts for file descriptor usage.
        Regular Load Testing: Schedule quarterly load testing to validate server performance under high traffic conditions.
        Documentation: Update the incident response playbook to include steps for checking ULIMIT and other resource limits during high failure rate scenarios.

By addressing these measures, we aim to prevent similar incidents in the future and ensure our web server setup can reliably handle high traffic volumes.
