<?php

namespace docker {
    function adminer_object()
    {
        class Adminer extends \Adminer
        {
            function loginForm()
            {
                ob_start();
                $return = parent::loginForm();
                $form = ob_get_clean();

                $form = str_replace('name="auth[server]" value="" title="hostname[:port]"', 'name="auth[server]" value="postgres" title="hostname[:port]"', $form);
                $form = str_replace('<option value="server" selected>', '<option value="server">', $form);
                $form = str_replace('<option value="pgsql">', '<option value="pgsql" selected>', $form);
                $form = str_replace('id="username" value=""', 'id="username" value="USERNAME"', $form);
                $form = str_replace('name="auth[password]"', 'name="auth[password]" value="PASSWORD"', $form);
                $form = str_replace('name="auth[db]" value=""', 'name="auth[db]" value="DATABASE"', $form);

                echo $form;

                return $return;
            }
        }

        return new Adminer();
    }
}

namespace {
    function adminer_object()
    {
        return \docker\adminer_object();
    }

    require('adminer.php');
}
