const main = async () => {
  /* const [owner, randomPerson] = await hre.ethers.getSigners();
  */
  const hugContractFactory = await hre.ethers.getContractFactory('WavePortal');
  const hugContract = await hugContractFactory.deploy({
    value: hre.ethers.utils.parseEther('0.1'),
  });
  await hugContract.deployed();
  console.log("Contract address:", hugContract.address);
  /*
  * console.log("Contract deployed by:", owner.address);

  * Get contract balance
  */
  let contractBalance = await hre.ethers.provider.getBalance(
    hugContract.address
  );
  console.log(
    'Contract balance:',
  hre.ethers.utils.formatEther(contractBalance)
);

  /*
  * Send Hugs
  */
  const hugTxn = await hugContract.hug('Twitter account 1');
  await hugTxn.wait();

  const hugTxn2 = await hugContract.hug('Twitter account 2');
  await hugTxn2.wait();

  /*
  * Get Contract balance to see what happened
  */
  contractBalance = await hre.ethers.provider.getBalance(hugContract.address);
  console.log(
    'Contract balance:',
  hre.ethers.utils.formatEther(contractBalance)
);

/*  let hugCount;
  hugCount = await hugContract.getTotalHugs();

  const [_, randomPersonMsg] = await hre.ethers.getSigners();
  hugTxn = await hugContract.connect(randomPersonMsg).hug('You are bold');
  await hugTxn.wait();
  */

  let allHugs = await hugContract.getAllHugs();
  console.log(allHugs);
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();
