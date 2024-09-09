### GoldFinder: Comprehensive Automated Recon and Vulnerability Assessment Tool


GoldFinder is an advanced Bash script that automates subdomain enumeration, URL crawling, and vulnerability testing. It integrates essential tools like `subfinder`, `waybackurls`, `sqlmap`, `nuclei`, and more. Results are systematically organized for efficient analysis. It was developed two years ago and has been an invaluable tool in my bug bounty efforts. I am now sharing it with the community to assist newcomers and experienced researchers alike in their security assessments.


**Usage:**
- `./sam.sh -d [domain]` for domain-based scans

- ![image](https://github.com/user-attachments/assets/ccfe23c2-7dbc-49ed-a6e4-5d9bd23d7a3e)

- `./sam.sh -t target.txt ` for file-based targets

- ![image](https://github.com/user-attachments/assets/a92b2c0b-6981-4f87-b487-c2ba67f4f773)

  
**Key Features:**

1. **Subdomain Enumeration:**
   - Conducts thorough brute force subdomain discovery.
   - Saves discovered subdomains into two directories: *Valid Subdomains* and *All Subdomains*.

2. **Crawling and URL Extraction:**
   - Extracts unique URLs from the discovered subdomains.
   - Filters for various types of URLs including:
     - JavaScript files
     - Potentially sensitive paths
     - Backup files
     - Possible usernames
     - Error pages
     - Third-party assets
     - Sensitive files (e.g., `.xlsx`, `robots.txt`, log files, panel files)

3. **Vulnerability Testing:**
   - **Cross-Site Scripting (XSS):** Tests input parameters in unique URLs for XSS vulnerabilities.
   - **SQL Injection:** Detects SQL parameters and tests for SQL Injection vulnerabilities.
   - **Server-Side Request Forgery (SSRF):** Identifies SSRF parameters and provides notifications for potential issues.
   - **Subdomain Takeover:** Checks for potential subdomain takeover opportunities and alerts you if any are found.

4. **Nuclie Search:**
   - Performs Nuclie searches to uncover additional relevant information and vulnerabilities.
   - Saves search results in their appropriate directories for easy access and analysis.

5. **Organized Output:**
   - Categorizes and arranges results into separate directories for clear visibility, making it easier to review and analyze findings.

**Usage Instructions:**
1. Execute the script.
2. Allow the script to run for approximately one hour (processing time may vary based on the target size).
3. Review the organized results to identify and address vulnerabilities.

Required Tools:

    Subfinder :- https://github.com/projectdiscovery/subfinder
    Qsreplace :- https://github.com/tomnomnom/qsreplace
    Freq :- https://github.com/takshal/freq
    Tee :- https://ioflood.com/blog/install-tee-command-linux/
    Waybackurls :- https://github.com/tomnomnom/waybackurls
    Gau         :- https://github.com/lc/gau
    SQLmap      :- https://github.com/sqlmapproject/sqlmap
    Nuclei      :- https://github.com/projectdiscovery/nuclei
    Gauplus     :- https://github.com/bp0lr/gauplus
    Figlet      :- https://gist.github.com/kenny-kvibe/b1b7c4948c7406309eb66da3ed2a8144
    Httpx       :- https://github.com/projectdiscovery/httpx
    Uro         :- https://github.com/s0md3v/uro
    Subzy       :- https://github.com/PentestPad/subzy
    Sub404      :- https://github.com/r3curs1v3-pr0xy/sub404
    GF          :- https://github.com/tomnomnom/gf

Usage:

    ./goldfinder.sh -d [domain] for domain-based scans
    ./goldfinder.sh -t [target file] for file-based targets

For detailed installation instructions and tool setup, please refer to each tool’s respective documentation.
---

Feel free to connect
