<?php

use CodeIgniter\Router\RouteCollection;

/**
 * @var RouteCollection $routes
 */
$routes->get('/', 'Home::index');

$routes->get('laporan', 'Laporan::index');
$routes->get('laporan/(:segment)', 'Laporan::show/$1');
$routes->post('laporan/create', 'Laporan::create');
$routes->post('laporan/edit/(:segment)', 'Laporan::update/$1');
$routes->delete('laporan/(:segment)', 'Laporan::delete/$1');