const notas = artifacts.require("notas");

contract("notas", accounts => {
    it("Debería retornar el name y symbol del token creado", async () => {
        let instance = await notas.deployed();

        let _name = await instance.name.call();
        let _symbol = await instance.symbol.call();

        assert.equal(_name, "Notas");
        assert.equal(_symbol, "NOT");
    });

    it("Debería comprobar tokens minteados", async () => {
        let instance = await notas.deployed();

        let tokens_creados = 1000

        let _balance_tokens_minteados = await instance.totalSupply();
        assert.equal(_balance_tokens_minteados, tokens_creados);
    });

    it("Debería comprobar metodo para obtener balance de tokens del Smart Contract", async () => {
        let instance = await notas.deployed();

        let tokens_creados = 1000

        let _balance_tokens_smart_contract = await instance.balanceTokensSC();
        assert.equal(_balance_tokens_smart_contract, tokens_creados);
    });
})