Shader "Mine/BuffersAndQueues" {

    Properties
    {
        _diffuseTex ("Diffuse Texture", 2D) = "white" {}
    }

    SubShader 
    {
        Tags { "Queue" = "Geometry+100" }
        ZWrite Off
        CGPROGRAM
            #pragma surface surf Lambert

            sampler2D _diffuseTex;

            struct Input 
            {
                float2 uv_diffuseTex;
            };

            void surf (Input IN, inout SurfaceOutput o)
            {
                o.Albedo = (tex2D(_diffuseTex, IN.uv_diffuseTex)).rgb;
            }

        ENDCG
    }

    FallBack "Diffuse"
}