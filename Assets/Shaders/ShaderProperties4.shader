Shader "Mine/ShaderProperties4" {

    Properties
    {
        _diffuseTex ("Diffuse Texture", 2D) = "white" {}
        // _emissiveTex ("Emmision Texture", 2D) = "white" {}
        
        //set this texture to black to stop the white
        //overwhelming the effect if no emission texture
        //is present
        _emissiveTex ("Texture", 2D) = "black" {}
    }

    SubShader 
    {
        CGPROGRAM
            #pragma surface surf Lambert

            sampler2D _diffuseTex;
            sampler2D _emissiveTex;

            struct Input 
            {
                float2 uv_diffuseTex;
                float2 uv_emissiveTex;
            };

            void surf (Input IN, inout SurfaceOutput o)
            {
                o.Albedo = (tex2D(_diffuseTex, IN.uv_diffuseTex)).rgb;
                o.Emission = (tex2D(_emissiveTex, IN.uv_emissiveTex)).rgb;
            }

        ENDCG
    }

    FallBack "Diffuse"
}