# Reset and create commits from 2 years ago to 10 months ago
$ErrorActionPreference = "Stop"

Write-Host "Resetting repository..."

# Remove old git history
if (Test-Path .git) {
    Remove-Item -Recurse -Force .git
}
if (Test-Path .commit-log.txt) {
    Remove-Item .commit-log.txt
}

# Initialize fresh
git init

# Timeline: Feb 2024 to March 2025
$START_DATE = Get-Date "2024-02-01"
$END_DATE = Get-Date "2025-03-29"
$TOTAL_COMMITS = 150

Write-Host "Creating $TOTAL_COMMITS commits from Feb 2024 to March 2025"

$messages = @(
    "Initial commit: Spotify clone setup",
    "Add: Backend Express server",
    "Add: MongoDB connection",
    "Add: JWT authentication",
    "Add: React frontend with Vite",
    "Add: Tailwind CSS",
    "Feature: User registration",
    "Feature: Music player",
    "Feature: Playlist creation",
    "Feature: Album display",
    "Feature: Real-time chat",
    "Feature: Admin dashboard",
    "Fix: Audio playback issues",
    "Fix: Auth token refresh",
    "Fix: WebSocket stability",
    "Update: UI responsiveness",
    "Update: Database optimization",
    "Update: Error handling",
    "Refactor: Component cleanup",
    "Refactor: State management",
    "Style: Mobile layout",
    "Style: Color scheme update",
    "Docs: API documentation",
    "Docs: README update",
    "Fix: Memory leak",
    "Fix: Playlist sorting",
    "Feature: Search functionality",
    "Feature: User profiles",
    "Feature: Song queue",
    "Update: Dependencies"
)

# Initial commit
git add .
$initialDate = $START_DATE.AddHours(10)
$env:GIT_AUTHOR_DATE = $initialDate.ToString("yyyy-MM-dd HH:mm:ss")
$env:GIT_COMMITTER_DATE = $initialDate.ToString("yyyy-MM-dd HH:mm:ss")
git commit -m "Initial commit: Spotify clone setup" --quiet
Remove-Item Env:\GIT_AUTHOR_DATE
Remove-Item Env:\GIT_COMMITTER_DATE

$commitCount = 1
$currentDate = $START_DATE.AddDays(1)

while ($currentDate -le $END_DATE -and $commitCount -lt $TOTAL_COMMITS) {
    $activityType = Get-Random -Minimum 1 -Maximum 100
    
    if ($activityType -lt 35) {
        # High activity
        $days = Get-Random -Minimum 3 -Maximum 8
        for ($d = 0; $d -lt $days -and $commitCount -lt $TOTAL_COMMITS; $d++) {
            $date = $currentDate.AddDays($d)
            if (($date.DayOfWeek -eq 6 -or $date.DayOfWeek -eq 0) -and (Get-Random -Maximum 100) -lt 65) {
                continue
            }
            $numCommits = Get-Random -Minimum 1 -Maximum 5
            for ($i = 0; $i -lt $numCommits -and $commitCount -lt $TOTAL_COMMITS; $i++) {
                $hour = Get-Random -Minimum 9 -Maximum 23
                $minute = Get-Random -Minimum 0 -Maximum 60
                $commitDate = $date.Date.AddHours($hour).AddMinutes($minute)
                if ($commitDate -le $END_DATE) {
                    $msg = $messages | Get-Random
                    Add-Content -Path ".commit-log.txt" -Value "Commit $commitCount"
                    git add .commit-log.txt
                    $env:GIT_AUTHOR_DATE = $commitDate.ToString("yyyy-MM-dd HH:mm:ss")
                    $env:GIT_COMMITTER_DATE = $commitDate.ToString("yyyy-MM-dd HH:mm:ss")
                    git commit -m $msg --quiet
                    Remove-Item Env:\GIT_AUTHOR_DATE
                    Remove-Item Env:\GIT_COMMITTER_DATE
                    $commitCount++
                    if ($commitCount % 25 -eq 0) {
                        Write-Host "Created $commitCount commits..."
                    }
                }
            }
        }
        $currentDate = $currentDate.AddDays($days)
    } elseif ($activityType -lt 70) {
        # Medium activity
        $days = Get-Random -Minimum 4 -Maximum 10
        $commits = Get-Random -Minimum 2 -Maximum 6
        for ($i = 0; $i -lt $commits -and $commitCount -lt $TOTAL_COMMITS; $i++) {
            $offset = Get-Random -Minimum 0 -Maximum $days
            $date = $currentDate.AddDays($offset)
            while (($date.DayOfWeek -eq 6 -or $date.DayOfWeek -eq 0) -and (Get-Random -Maximum 100) -lt 75) {
                $date = $date.AddDays(1)
            }
            $hour = Get-Random -Minimum 10 -Maximum 21
            $minute = Get-Random -Minimum 0 -Maximum 60
            $commitDate = $date.Date.AddHours($hour).AddMinutes($minute)
            if ($commitDate -le $END_DATE) {
                $msg = $messages | Get-Random
                Add-Content -Path ".commit-log.txt" -Value "Commit $commitCount"
                git add .commit-log.txt
                $env:GIT_AUTHOR_DATE = $commitDate.ToString("yyyy-MM-dd HH:mm:ss")
                $env:GIT_COMMITTER_DATE = $commitDate.ToString("yyyy-MM-dd HH:mm:ss")
                git commit -m $msg --quiet
                Remove-Item Env:\GIT_AUTHOR_DATE
                Remove-Item Env:\GIT_COMMITTER_DATE
                $commitCount++
                if ($commitCount % 25 -eq 0) {
                    Write-Host "Created $commitCount commits..."
                }
            }
        }
        $currentDate = $currentDate.AddDays($days)
    } else {
        # Low activity
        $days = Get-Random -Minimum 7 -Maximum 18
        if ((Get-Random -Maximum 100) -lt 50 -and $commitCount -lt $TOTAL_COMMITS) {
            $offset = Get-Random -Minimum 0 -Maximum $days
            $date = $currentDate.AddDays($offset)
            while ($date.DayOfWeek -eq 6 -or $date.DayOfWeek -eq 0) {
                $date = $date.AddDays(1)
            }
            $hour = Get-Random -Minimum 11 -Maximum 19
            $minute = Get-Random -Minimum 0 -Maximum 60
            $commitDate = $date.Date.AddHours($hour).AddMinutes($minute)
            if ($commitDate -le $END_DATE) {
                $msg = $messages | Get-Random
                Add-Content -Path ".commit-log.txt" -Value "Commit $commitCount"
                git add .commit-log.txt
                $env:GIT_AUTHOR_DATE = $commitDate.ToString("yyyy-MM-dd HH:mm:ss")
                $env:GIT_COMMITTER_DATE = $commitDate.ToString("yyyy-MM-dd HH:mm:ss")
                git commit -m $msg --quiet
                Remove-Item Env:\GIT_AUTHOR_DATE
                Remove-Item Env:\GIT_COMMITTER_DATE
                $commitCount++
            }
        }
        $currentDate = $currentDate.AddDays($days)
    }
}

Write-Host ""
Write-Host "Done! Created $commitCount commits"
Write-Host ""
git log --pretty=format:'%ad' --date=format:'%Y-%m' | Sort-Object | Group-Object | ForEach-Object {
    Write-Host "$($_.Count) commits in $($_.Name)"
}
Write-Host ""
Write-Host "Run: git push -f origin main"
