<?php
new class
{
    protected $execTime = 3;

    protected function getPath(string $name)
    {
        $map = [
            'course_v2_v5_temp' => ['/data/wwwroot/course_v2_v5_temp'],
            'course_v2'         => ['/data/wwwroot/course_v2'],
            'yx_hsr_v5_temp'    => ['/data/wwwroot/yx_hsr_v5_temp'],
            'xiaoti_cms'        => ['/data/wwwroot/xiaoti_cms'],
            'yx_course'         => ['/data/wwwroot/yx_course' => [__DIR__ . "/.hook-apidoc.sh /data/wwwroot/yx_course/app"]],
            'yx_course_doc'     => ['/data/wwwroot/yx_course_doc'],
            'opCenter'          => ['/data/wwwroot/opCenter' => [__DIR__ . '/.opCenter.sh']],
            'op_web'            => ['/data/wwwroot/op_web'],
            'yx_bullet'         => ['/data/wwwroot/yx_bullet' => [__DIR__ . "/.bullet-init.sh"]],
        ];
        return $map[$name];
    }

    public function __construct()
    {
        ini_set('display_errors', '1');
        error_reporting(E_ALL);
        $params = $this->getParams();
        $dir    = $this->getPath($params['repository']['name']);
        foreach ($dir as $key => $com) {
            $path = is_array($com) ? $key : $com;
            $this->exec(__DIR__ . "/.hook.sh {$path}");
            if (is_array($com) && !empty($com)) {
                foreach ($com as $c) {
                    $this->exec($c);
                }
            }
        }
    }

    protected function exec(string $command)
    {
        static $connection;
        if (empty($connection)) {
            ssh2_auth_password($connection = ssh2_connect('localhost', 22), "root", "Hello2018.!@#");
        }
        $shell = ssh2_shell($connection, 'bash');
        $this->user_exec($shell, $command);
        fclose($shell);
    }

    protected function getParams()
    {
        return json_decode(file_get_contents("php://input"), true);
    }

    protected function user_exec($shell, $cmd)
    {
        fwrite($shell, $cmd . "\n");
        $start_time = time();
        $max_time   = 2;
        while (((time() - $start_time) < $max_time)) {
            $line = fgets($shell);
            echo $line;
            $filename = null;
            if ($this->execTime > 0 && false == ($this->check($line, $filename))) {
                $this->user_exec($shell, $delete = __DIR__ . '/.delete-lock.sh '.$filename);
                $this->user_exec($shell, $cmd);
                $this->execTime--;
                break;
            }
            continue;
        }
    }

    protected function check($str, &$filename)
    {
        //$str = "fatal: Unable to create '/data/wwwroot/op_web/.git/refs/remotes/origin/dev-v5.lock'";
        if (preg_match("/fatal: Unable to create '(.*.lock)'/", $str, $match)) {
            $filename = $match[1];
            return false;
        }
        return true;
    }
};
