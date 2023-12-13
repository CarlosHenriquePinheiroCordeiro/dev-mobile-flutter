<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Localizacao;

class ControllerLocalizacao extends Controller
{
    
    public function index()
    {
        $response = response()->json(Localizacao::all());

        $response->header('Access-Control-Allow-Origin', '*');
        $response->header('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
        $response->header('Access-Control-Allow-Headers', 'Content-Type, Accept, Authorization, X-Requested-With, X-Token-Auth, Origin');

        return $response;
    }

    public function store(Request $request)
    {
        $oModel = new Localizacao();
        $oModel->nome        = $request->nome;
        $oModel->coordenadas = $request->coordenadas;
        return $oModel->save();
    }

    public function show(string $id)
    {
        $oModel = Localizacao::find($id);
        return json_encode([$oModel->id, $oModel->nome, $oModel->coordenadas]);
    }

    public function destroy(string $id)
    {
        return Localizacao::find($id)->delete();
    }
}
