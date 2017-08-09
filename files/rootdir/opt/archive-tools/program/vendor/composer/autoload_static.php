<?php

// autoload_static.php @generated by Composer

namespace Composer\Autoload;

class ComposerStaticInit7c26d93d12886b741a075aedcac8b027
{
    public static $prefixLengthsPsr4 = array (
        'P' => 
        array (
            'PhpMimeMailParser\\' => 18,
        ),
    );

    public static $prefixDirsPsr4 = array (
        'PhpMimeMailParser\\' => 
        array (
            0 => __DIR__ . '/..' . '/php-mime-mail-parser/php-mime-mail-parser/src',
        ),
    );

    public static function getInitializer(ClassLoader $loader)
    {
        return \Closure::bind(function () use ($loader) {
            $loader->prefixLengthsPsr4 = ComposerStaticInit7c26d93d12886b741a075aedcac8b027::$prefixLengthsPsr4;
            $loader->prefixDirsPsr4 = ComposerStaticInit7c26d93d12886b741a075aedcac8b027::$prefixDirsPsr4;

        }, null, ClassLoader::class);
    }
}
