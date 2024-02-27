<?php
require_once 'vendor/autoload.php';
use Symfony\Component\Process\Process;
$process = new Process(['flutter', 'build', 'apk', '--release']);
echo "building apk.....";
$process->run();
if (!$process->isSuccessful()) {
    die('Failed to build APK file: ' . $process->getErrorOutput());
}
$apkPath = 'build/app/outputs/apk/release/app.apk';
if (!file_exists($apkPath)) {
    die('APK file does not exist: ' . $apkPath);
}
header('Content-Type: application/vnd.android.package-archive');
header('Content-Disposition: attachment; filename="' . $apkPath . '"');
readfile($apkPath);
echo "apk done .....";
?>