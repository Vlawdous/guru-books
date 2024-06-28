<?php

namespace App\Controller\Test;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

#[Route(path: '/tests')]
class PingController extends AbstractController
{
    #[Route(path: '/ping')]
    public function ping(): Response
    {
        return $this->json(['result' => 'pong']);
    }
}
