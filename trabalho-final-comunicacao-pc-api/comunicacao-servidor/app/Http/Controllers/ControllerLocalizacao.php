<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Localizacao;

class ControllerLocalizacao extends Controller
{
    
    public function index()
    {
        $aDados = Localizacao::all();
        $aJson = [];
        foreach (Localizacao::all() as $oModel) {
            $aJson[] = [$oModel->id, $oModel->nome, $oModel->coordenadas];
        }
        return json_encode($aJson);
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
