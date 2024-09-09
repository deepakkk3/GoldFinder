### GoldFinder: Comprehensive Automated Recon and Vulnerability Assessment Tool

GoldFinder is an advanced Bash script that automates  enumeration, URL crawling, and vulnerability testing. It integrates essential tools. It spawns URLS and filters Sensitive Info.Results are systematically organized for efficient analysis. It was developed two years ago and has been an invaluable tool in my bug bounty efforts. I am now sharing it with the community to assist newcomers and experienced researchers alike in their security assessments.

**What are the Dependencies?**

- [Subfinder](https://github.com/projectdiscovery/subfinder)
- [Qsreplace](https://github.com/projectdiscovery/qsreplace)
- [Freq](https://github.com/freq/freq)
- [Tee](https://man7.org/linux/man-pages/man1/tee.1.html)
- [Waybackurls](https://github.com/tomnomnom/waybackurls)
- [Gau](https://github.com/lc/gau)
- [SQLmap](https://github.com/sqlmapproject/sqlmap)
- [Nuclei](https://github.com/projectdiscovery/nuclei)
- [Gauplus](https://github.com/lc/gauplus)
- [Figlet](http://www.figlet.org/)
- [Httpx](https://github.com/projectdiscovery/httpx)
- [Uro](https://github.com/robertdavidgraham/uro)
- [Subzy](https://github.com/subzy/subzy)
- [Sub404](https://github.com/sub404/sub404)
- [GF](https://github.com/tomnomnom/gf)

**How To Install**

  Subfinder      ``` apt install subfinder```  
  
  Qsreplace    ``` go install github.com/tomnomnom/qsreplace@latest ``` 
    
  Freq         ``` go get -u github.com/takshal/freq ``` 
  
  Tee          ``` apt-get install coreutils ``` 
   
  Waybackurls  ``` go install github.com/tomnomnom/waybackurls@latest ``` 
   
  Gau          ``` go install github.com/lc/gau/v2/cmd/gau@latest ``` 
   
  SQLmap       ``` apt install sqlmap ``` 
   
  Nuclei       ``` apt install nuclei ``` 
  
  Gauplus      ``` go install github.com/bp0lr/gauplus@latest ``` 
  
  Figlet       ``` apt install figlet ``` 
   
  Httpx        ``` go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest ``` 
 
  Sub404        ``` https://github.com/r3curs1v3-pr0xy/sub404``` 
  
  Subzy        ``` go install -v github.com/PentestPad/subzy@latest ``` 
  
  GF           ``` go get -u github.com/tomnomnom/gf ``` 
  
  Uro          ``` pip3 install uro ``` 

``git clone https://github.com/deepakkk3/GoldFinder.git ``   

``cd GoldFinder``

``chmod +x sam.sh`` 

For detailed installation instructions and tool setup, please refer to each tool’s respective documentation.
---


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


Feel free to connect on X (twitter) 
    :-https://x.com/s4msec
