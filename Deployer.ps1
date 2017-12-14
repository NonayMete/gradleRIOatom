$file = New-Object System.IO.StreamReader -Arg "C:\Users\jakel\AppData\Local\atom\app-1.23.1\logfile.dat"
while ($line = $file.ReadLine()) {
    if ($line -eq "ECHO is off.") {
    echo "No path file set, set path file in options."
    $file.close()
    exit 1
    }
    else {
    cd $line
    echo "Program location -> $line"
    ./gradlew deploy
    $file.close()
    exit $LASTEXITCODE
}
}