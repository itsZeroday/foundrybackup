#!/bin/bash

send_discord_notification() {
    local status=$1
    local message=$2
    local color
    
    # Set color based on status (green for success, red for failure)
    if [ "$status" == "SUCCESS" ]; then
        color="65280"  
    else
        color="16711680"  
    fi
    
    local payload=$(cat <<EOF
        {
          "embeds": [{
            "title": "Foundry VTT Backup $status",
            "description": "$message",
            "color": $color,
            "fields": [
              {
                "name": "Server",
                "value": "CasaOS to $SOURCE_SERVER",
                "inline": true
              },
              {
                "name": "Time",
                "value": "$(date)",
                "inline": true
              }
            ]
          }]
        }
        EOF
        )
            
            curl -s -H "Content-Type: application/json" -d "$payload" "$DISCORD_WEBHOOK_URL"
        }

        echo "Starting backup from ${SOURCE_USER}@${SOURCE_SERVER}:${SOURCE_DIR} to ${DEST_DIR}"
        echo "Started at: $(date)"

        export SSHPASS="$SSH_PASSWORD"

        send_discord_notification "STARTED" "Foundry VTT backup job has begun."

        sshpass -e rsync -avz --delete -e "ssh -o StrictHostKeyChecking=no" \
            "${SOURCE_USER}@${SOURCE_SERVER}:${SOURCE_DIR}" "${DEST_DIR}"

        BACKUP_STATUS=$?

        BACKUP_SIZE=$(du -sh "$DEST_DIR" | cut -f1)

        if [ $BACKUP_STATUS -eq 0 ]; then
            echo "Backup completed successfully at $(date)"
            STATUS_MESSAGE="SUCCESS"
            DISCORD_MESSAGE="Backup completed successfully. Total size: $BACKUP_SIZE"
        else
            echo "Backup failed with status $BACKUP_STATUS at $(date)"
            STATUS_MESSAGE="FAILED"
            DISCORD_MESSAGE="Backup failed with status code $BACKUP_STATUS. Please check logs."
        fi

        send_discord_notification "$STATUS_MESSAGE" "$DISCORD_MESSAGE"

        if [ -d "$DEST_DIR" ] && [ -w "$DEST_DIR" ]; then
            {
                echo "==============================================="
                echo "Backup run: $(date)"
                echo "From: ${SOURCE_USER}@${SOURCE_SERVER}:${SOURCE_DIR}"
                echo "To: ${DEST_DIR}"
                echo "Size: $BACKUP_SIZE"
                echo "Status: $STATUS_MESSAGE"
                echo "==============================================="
            } >> "$LOG_FILE"
        fi

        unset SSHPASS

        exit $BACKUP_STATUS

if [ $BACKUP_STATUS -eq 0 ]; then
    echo "Backup completed successfully at $(date)"
    STATUS_MESSAGE="SUCCESS"
    DISCORD_MESSAGE="Backup completed successfully. Total size: $BACKUP_SIZE"
else
    echo "Backup failed with status $BACKUP_STATUS at $(date)"
    STATUS_MESSAGE="FAILED"
    DISCORD_MESSAGE="Backup failed with status code $BACKUP_STATUS. Please check logs."
fi

send_discord_notification "$STATUS_MESSAGE" "$DISCORD_MESSAGE"

if [ -d "$DEST_DIR" ] && [ -w "$DEST_DIR" ]; then
    {
        echo "==============================================="
        echo "Backup run: $(date)"
        echo "From: ${SOURCE_USER}@${SOURCE_SERVER}:${SOURCE_DIR}"
        echo "To: ${DEST_DIR}"
        echo "Size: $BACKUP_SIZE"
        echo "Status: $STATUS_MESSAGE"
        echo "==============================================="
    } >> "$LOG_FILE"
fi

unset SSHPASS

exit $BACKUP_STATUS

if [ $BACKUP_STATUS -eq 0 ]; then
    echo "Backup completed successfully at $(date)"
    STATUS_MESSAGE="SUCCESS"
    DISCORD_MESSAGE="Backup completed successfully. Total size: $BACKUP_SIZE"
else
    echo "Backup failed with status $BACKUP_STATUS at $(date)"
    STATUS_MESSAGE="FAILED"
    DISCORD_MESSAGE="Backup failed with status code $BACKUP_STATUS. Please check logs."
fi

send_discord_notification "$STATUS_MESSAGE" "$DISCORD_MESSAGE"

if [ -d "$DEST_DIR" ] && [ -w "$DEST_DIR" ]; then
    {
        echo "==============================================="
        echo "Backup run: $(date)"
        echo "From: ${SOURCE_USER}@${SOURCE_SERVER}:${SOURCE_DIR}"
        echo "To: ${DEST_DIR}"
        echo "Size: $BACKUP_SIZE"
        echo "Status: $STATUS_MESSAGE"
        echo "==============================================="
    } >> "$LOG_FILE"
fi

unset SSHPASS

exit $BACKUP_STATUS

if [ $BACKUP_STATUS -eq 0 ]; then
    echo "Backup completed successfully at $(date)"
    STATUS_MESSAGE="SUCCESS"
    DISCORD_MESSAGE="Backup completed successfully. Total size: $BACKUP_SIZE"
else
    echo "Backup failed with status $BACKUP_STATUS at $(date)"
    STATUS_MESSAGE="FAILED"
    DISCORD_MESSAGE="Backup failed with status code $BACKUP_STATUS. Please check logs."
fi

send_discord_notification "$STATUS_MESSAGE" "$DISCORD_MESSAGE"

if [ -d "$DEST_DIR" ] && [ -w "$DEST_DIR" ]; then
    {
        echo "==============================================="
        echo "Backup run: $(date)"
        echo "From: ${SOURCE_USER}@${SOURCE_SERVER}:${SOURCE_DIR}"
        echo "To: ${DEST_DIR}"
        echo "Size: $BACKUP_SIZE"
        echo "Status: $STATUS_MESSAGE"
        echo "==============================================="
    } >> "$LOG_FILE"
fi

unset SSHPASS

exit $BACKUP_STATUS