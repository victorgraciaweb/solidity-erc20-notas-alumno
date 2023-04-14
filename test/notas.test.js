const notas = artifacts.require("notas");

contract("notas", accounts => {
    it("Debería retornar el name del token creado", async () => {
        let instance = await notas.deployed();

        let _name = await instance.name.call();
        assert.equal(_name, "Notas");
    });
})