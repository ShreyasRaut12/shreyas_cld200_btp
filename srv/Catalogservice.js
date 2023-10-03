module.exports = cds.service.impl( async function(){
    //here we can use our DB tables as objects
    const { PurchaseOrder, PurchaseOrderItems } = this.entities;
    this.on('boost', async (req,res) => {
        try {
            const ID = req.params[0];
            console.log("Hey Amigo, Your purchase order with id " + req.params[0] + " will be boosted");
            const tx = cds.tx(req);
            //CDS Query Language - communicate to DB in agnostic manner
            await tx.update(PurchaseOrder).with({
                GROSS_AMOUNT: { '+=' : 20000 },
                NOTE: 'Boosted!!'
            }).where(ID);
        } catch (error) {
            return "Error " + error.toString();
        }
    });
    this.on('getOrderDefaults', async req => {
        return {OVERALL_STATUS: 'N'};
      });

      this.on('setOrderProcessing', PurchaseOrder, async req => {
        const tx = cds.tx(req);
        await tx.update(PurchaseOrder, req.params[0].ID).set({OVERALL_STATUS: 'D'});
    });

    this.on('largestOrder', async (req,res) => {
        try {
            //const ID = req.params[0];
            const tx = cds.tx(req);
            
            //SELECT * UPTO 1 ROW FROM dbtab ORDER BY GROSS_AMOUNT desc
            const reply = await tx.read(PurchaseOrder).orderBy({
                GROSS_AMOUNT: 'desc'
            }).limit(1);
            return reply;
        } catch (error) {
            return "Error " + error.toString();
        }
    });
    
})

