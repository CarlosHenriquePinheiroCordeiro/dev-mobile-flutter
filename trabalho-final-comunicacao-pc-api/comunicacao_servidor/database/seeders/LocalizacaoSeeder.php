<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class LocalizacaoSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $aDados = [
            ['nome' => 'Ituporanga'   , 'coordenadas' => '-27.4215239,-49.6152393'],
            ['nome' => 'Rio do Sul'   , 'coordenadas' => '-27.2057479,-49.6645014'],
            ['nome' => 'Aurora'       , 'coordenadas' => '-27.3094063,-49.6468021'],
            ['nome' => 'Florianópolis', 'coordenadas' => '-27.570596,-48.8006068' ]
        ];
        foreach ($aDados as $aRegistro) {
            DB::table('localizacaos')->insert($aRegistro);
        }
    }
}
