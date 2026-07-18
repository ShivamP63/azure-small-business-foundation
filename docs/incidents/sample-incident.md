# Sample Incident Report: Missing VM Heartbeat

## Incident Summary

| Field | Value |
|---|---|
| Incident ID | `INC-2026-001` |
| Service | Contoso internal Linux application VM |
| Resource | `vm-contoso-app-dev-01` |
| Severity | SEV-3 / Low business impact |
| Detection source | Azure Monitor scheduled-query alert |
| Status | Resolved |
| Scenario | Controlled portfolio validation |

Azure Monitor detected that the VM had stopped sending Heartbeat records to Log Analytics for more than five minutes. The action group delivered an email notification. Investigation confirmed that the VM had been intentionally stopped to validate availability monitoring. The VM was restarted, Heartbeat ingestion resumed, and Azure Monitor automatically resolved the alert.

## Timeline

| Relative time | Event |
|---|---|
| T+00 | VM stopped as part of the planned alert test |
| T+05 | Missing-heartbeat query met the alert threshold |
| T+06 | Action group sent the fired notification email |
| T+08 | Operator reviewed the alert rule and VM power state |
| T+10 | VM restart initiated |
| T+13 | Azure Monitor Agent resumed Heartbeat transmission |
| T+15 | Query returned current heartbeat data |
| T+16 | Alert state changed to resolved and email was received |

## Detection

The scheduled-query rule evaluated Heartbeat data in the Log Analytics workspace and detected that the target VM had no recent records. The following query was used during investigation:

```kusto
Heartbeat
| where Computer =~ "vm-contoso-app-dev-01"
| summarize LastHeartbeat=max(TimeGenerated) by Computer
| extend MinutesSinceLastHeartbeat=datetime_diff("minute", now(), LastHeartbeat)
```

## Investigation

1. Confirmed the alert targeted the correct VM and workspace.
2. Checked the VM instance view and found the power state was stopped/deallocated.
3. Confirmed there was no active Azure Monitor Agent extension failure.
4. Reviewed recent Heartbeat records to identify when telemetry stopped.
5. Verified no concurrent high-severity Syslog events indicated an unexpected operating-system failure.

## Root Cause

The immediate cause was an intentional VM shutdown performed to validate monitoring behavior. The alert worked as designed. In a real incident, likely causes would include VM shutdown, guest OS failure, agent failure, network disruption, or a DCR association problem.

## Resolution

The VM was restarted. Azure Monitor Agent reconnected and resumed sending Heartbeat data to the Log Analytics workspace. The alert automatically returned to a resolved state after the query again observed recent data.

## Impact

The internal application hosted on the VM was unavailable during the controlled shutdown. No data loss occurred, and no external customer traffic was affected. The backup recovery point remained available throughout the event.

## Corrective and Preventive Actions

- Keep the missing-heartbeat alert enabled and routed to the operations action group.
- Document expected maintenance windows to reduce false-positive escalation.
- Add a check for VM power state and AMA extension status to the investigation runbook.
- Review alert frequency and threshold after collecting a longer operating baseline.
- In production, define an escalation path, ownership rotation, and service-level objectives.

## Evidence

- `37-heartbeat-alert-email-fired.png`
- `38-heartbeat-alert-email-resolved.png`
- `29-heartbeat-kql-results.png`

## Lessons Learned

The test demonstrated that telemetry collection, query evaluation, action-group notification, operator investigation, service restoration, and automatic alert resolution all worked end to end.
