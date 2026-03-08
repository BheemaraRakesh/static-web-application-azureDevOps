# Splunk Concepts

## Overview
Splunk is a powerful platform for searching, monitoring, and analyzing machine-generated data. It collects and indexes data from various sources and provides real-time insights through dashboards and alerts.

## Key Concepts

### 1. Data Ingestion

#### Data Sources
- **Files and Directories:** Log files, CSV files
- **Network Sources:** TCP/UDP ports, HTTP endpoints
- **APIs:** REST APIs, scripted inputs
- **Cloud Services:** AWS, Azure, GCP integrations
- **Forwarders:** Universal Forwarder, Heavy Forwarder

#### Input Methods
- **Monitor:** Continuously read files
- **Upload:** One-time file upload
- **TCP/UDP:** Network data streams
- **HTTP Event Collector (HEC):** REST API ingestion

**Example inputs.conf:**
```ini
[monitor:///var/log/apache/access.log]
sourcetype = access_combined
index = web

[tcp://:9997]
sourcetype = syslog
index = network
```

### 2. Indexing

#### Indexes
Storage containers for data.

**Default Indexes:**
- **main:** Default index
- **_internal:** Splunk internal logs
- **_audit:** User activity logs

#### Index Configuration
```ini
[web_logs]
homePath = $SPLUNK_DB/web_logs/db
coldPath = $SPLUNK_DB/web_logs/colddb
thawedPath = $SPLUNK_DB/web_logs/thaweddb
maxTotalDataSizeMB = 512000
```

### 3. Search Processing Language (SPL)

#### Basic Search
```spl
# Search for errors
index=main sourcetype=access_combined status=404

# Search with time range
index=main earliest=-1h latest=now() error

# Field extraction
index=main | extract auto
```

#### Common Commands
- **stats:** Statistical operations
- **chart/timechart:** Data visualization
- **table:** Tabular output
- **sort:** Sort results
- **dedup:** Remove duplicates
- **eval:** Calculate new fields
- **rex:** Regular expression extraction

**Example SPL:**
```spl
index=web sourcetype=access_combined
| stats count by status, uri_path
| sort -count
| head 10
```

### 4. Field Extractions

#### Automatic Extraction
Splunk automatically extracts fields based on sourcetype.

#### Custom Extractions
Using **rex** command or field extractions.

**Example:**
```spl
index=main sourcetype=apache
| rex field=_raw "GET (?<uri>\S+) HTTP"
| rex field=_raw "\" (?<user_agent>[^\"]+)\"$"
| table _time, uri, user_agent
```

#### Calculated Fields
```ini
# props.conf
[access_combined]
EVAL-response_time = response_time / 1000
EVAL-is_error = if(status >= 400, "true", "false")
```

### 5. Knowledge Objects

#### Event Types
Categorize events.

**Example:**
```ini
[web_errors]
search = index=web status>=400
color = red
```

#### Tags
Add metadata to fields.

**Example:**
```ini
[host]
webserver = enabled
```

#### Lookups
Enrich data with external data.

**Example CSV Lookup:**
```csv
ip,country,city
192.168.1.1,US,New York
192.168.1.2,UK,London
```

### 6. Dashboards and Visualizations

#### Simple XML
```xml
<dashboard>
  <label>Web Analytics</label>
  <row>
    <panel>
      <chart>
        <search>
          <query>index=web | timechart count by status</query>
        </search>
        <option name="charting.chart">line</option>
      </chart>
    </panel>
  </row>
</dashboard>
```

#### Dashboard Studio
Modern dashboard creation with drag-and-drop.

### 7. Alerts

#### Alert Types
- **Scheduled:** Run on schedule
- **Real-time:** Trigger on event arrival
- **Rolling Window:** Based on time window

#### Alert Actions
- **Email:** Send notifications
- **Webhook:** HTTP POST to external systems
- **Script:** Execute custom scripts
- **Slack/PagerDuty:** Integration with collaboration tools

**Example Alert:**
```spl
index=security sourcetype=firewall action=blocked
| stats count by src_ip
| where count > 100
```

### 8. Reports

#### Scheduled Reports
Run searches on schedule and save results.

#### Report Acceleration
Speed up frequently run searches.

**Enable Acceleration:**
```spl
index=web sourcetype=access_combined
| stats count by uri_path
| sort -count
| head 100
```

### 9. Data Models

#### Purpose
Abstract data for easier searching and reporting.

**Example Data Model:**
```json
{
  "objects": [
    {
      "objectName": "WebRequests",
      "fields": [
        {"fieldName": "uri", "fieldType": "string"},
        {"fieldName": "status", "fieldType": "number"},
        {"fieldName": "response_time", "fieldType": "number"}
      ]
    }
  ]
}
```

### 10. Splunk Enterprise Security (ES)

#### Use Cases
- Threat detection
- Incident response
- Compliance monitoring
- Risk analysis

#### Key Features
- **Correlation Searches:** Link related events
- **Notable Events:** High-priority alerts
- **Risk Scoring:** Quantify security risk
- **Asset and Identity Management:** Track assets and users

## Real Project Examples

### Web Server Monitoring
```spl
# Data input configuration
[monitor:///var/log/apache2/access.log]
sourcetype = access_combined
index = web

# Search for top pages
index=web sourcetype=access_combined
| stats count by uri_path
| sort -count
| head 20

# Error analysis
index=web sourcetype=access_combined status>=400
| stats count by status, uri_path
| sort -count

# Performance monitoring
index=web sourcetype=access_combined
| eval response_time_sec = response_time / 1000
| timechart avg(response_time_sec) by uri_path
```

### Security Monitoring
```spl
# Failed login attempts
index=security sourcetype=authentication action=failed
| stats count by user, src_ip
| where count > 5
| sort -count

# Brute force detection
index=security sourcetype=authentication action=failed
| bin _time span=1m
| stats count by _time, src_ip
| where count > 10

# Malware detection
index=security sourcetype=antivirus threat=*
| stats count by threat, host
| sort -count
```

### Infrastructure Monitoring
```spl
# Server performance
index=infra sourcetype=cpu
| timechart avg(cpu_percent) by host

# Disk space alerts
index=infra sourcetype=df
| where percent_used > 90
| table host, filesystem, percent_used

# Network traffic
index=infra sourcetype=netstat
| stats sum(bytes_in), sum(bytes_out) by host
| eval total_traffic = bytes_in + bytes_out
```

### Business Intelligence Dashboard
```xml
<dashboard>
  <label>E-commerce Analytics</label>
  <row>
    <panel>
      <title>Revenue Trend</title>
      <chart>
        <search>
          <query>index=ecommerce sourcetype=orders
          | timechart sum(amount) as revenue</query>
        </search>
        <option name="charting.chart">line</option>
      </chart>
    </panel>
    <panel>
      <title>Top Products</title>
      <chart>
        <search>
          <query>index=ecommerce sourcetype=orders
          | stats sum(quantity) as total_sold by product
          | sort -total_sold
          | head 10</query>
        </search>
        <option name="charting.chart">bar</option>
      </chart>
    </panel>
  </row>
  <row>
    <panel>
      <title>Customer Behavior</title>
      <table>
        <search>
          <query>index=ecommerce sourcetype=user_actions
          | stats count by action, user_id
          | sort -count
          | head 20</query>
        </search>
      </table>
    </panel>
  </row>
</dashboard>
```

### Alert Configuration
```spl
# High error rate alert
index=web sourcetype=access_combined status>=500
| timechart count span=5m
| where count > 100

# Alert action: Send email and create ticket
# Email subject: "High Error Rate Detected"
# Email body: "Error rate exceeded threshold. Check dashboard for details."
```

## Best Practices
- Use appropriate sourcetypes for automatic field extraction
- Implement data retention policies
- Use summary indexing for performance
- Create meaningful dashboards and alerts
- Implement proper access controls
- Use data models for consistent reporting
- Monitor Splunk performance itself
- Implement backup and disaster recovery
- Use forwarders for distributed data collection
- Regularly review and optimize searches