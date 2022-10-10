Shader "Mine/PassesAndBlending/BumpDiffuseStencil"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _DiffuseTexture ("Diffuse Texture", 2D) = "white" {}
        _BumpTexture ("Bump Texture", 2D) = "white" {}
        _BumpAmount ("Bump Amount", Range(0,10)) = 1
        
        _StencilRef("Stencil Ref", Float) = 1
        [Enum(UnityEngine.Rendering.CompareFunction)] _StencilComp("Stencil Comparison", Float) = 8
        [Enum(UnityEngine.Rendering.StencilOp)] _StencilOp("Stencil Opoeration", Float) = 2
    }
    SubShader
    {
        // Tags { "RenderType"="Geometry" }

        Stencil
        {
            Ref[_StencilRef]
            Comp[_StencilComp]
            Pass[_StencilOp]
        } 

        CGPROGRAM
            #pragma surface surf Lambert

            sampler2D _DiffuseTexture;
            sampler2D _BumpTexture;
            half _BumpAmount;
            float4 _Color;

            struct Input
            {
                float2 uv_DiffuseTexture;
                float2 uv_BumpTexture;
            };

            void surf (Input IN, inout SurfaceOutput o)
            {
                o.Albedo = tex2D(_DiffuseTexture, IN.uv_DiffuseTexture).rgb * _Color.rgb;
                o.Normal = UnpackNormal(tex2D(_BumpTexture, IN.uv_BumpTexture));
                o.Normal *= float3(_BumpAmount, _BumpAmount, 1);
            }
        ENDCG
    }
    FallBack "Diffuse"
}
