Shader "Mine/PassesAndBlending/StencilWall"
{
    Properties
    {
        //not used
        _Color ("Color", Color) = (1,1,1,1)
        
        _StencilRef("Stencil Ref", Float) = 1
        [Enum(UnityEngine.Rendering.CompareFunction)] _StencilComp("Stencil Comparison", Float) = 8
        [Enum(UnityEngine.Rendering.StencilOp)] _StencilOp("Stencil Opoeration", Float) = 2
    }
    SubShader
    {
        Tags { "Queue"="Geometry-1" }

       ZWrite off
       ColorMask 0

       Stencil
       {
            Ref[_StencilRef]
            Comp[_StencilComp]
            Pass[_StencilOp]
       } 

        CGPROGRAM
            #pragma surface surf Lambert

            sampler2D _myDiffuse;

            struct Input
            {
                float2 uv_MyDiffuse;
            };

            void surf (Input IN, inout SurfaceOutput o)
            {
                o.Albedo = tex2D(_myDiffuse, IN.uv_MyDiffuse).rgb;
            }
        ENDCG
    }
    FallBack "Diffuse"
}
