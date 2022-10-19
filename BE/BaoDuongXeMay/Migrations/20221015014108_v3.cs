using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace BaoDuongXeMay.Migrations
{
    public partial class v3 : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "DetailVehicle_User",
                columns: table => new
                {
                    IDDeatil = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    VehicleID = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    IDDetailNAU = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    UserID = table.Column<int>(type: "int", nullable: false),
                    KM_Current = table.Column<float>(type: "real", nullable: false),
                    RepairDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    DetaillNAUIDDetailNAU = table.Column<Guid>(type: "uniqueidentifier", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DetailVehicle_User", x => x.IDDeatil);
                    table.ForeignKey(
                        name: "FK_DetailVehicle_User_DetailNAU_DetaillNAUIDDetailNAU",
                        column: x => x.DetaillNAUIDDetailNAU,
                        principalTable: "DetailNAU",
                        principalColumn: "IDDetailNAU",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_User_DetailVehicleUser",
                        column: x => x.UserID,
                        principalTable: "User",
                        principalColumn: "UserID",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Vehicle_DetailVehicleUser",
                        column: x => x.VehicleID,
                        principalTable: "Vehicle",
                        principalColumn: "VehicleID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_DetailVehicle_User_DetaillNAUIDDetailNAU",
                table: "DetailVehicle_User",
                column: "DetaillNAUIDDetailNAU");

            migrationBuilder.CreateIndex(
                name: "IX_DetailVehicle_User_UserID",
                table: "DetailVehicle_User",
                column: "UserID");

            migrationBuilder.CreateIndex(
                name: "IX_DetailVehicle_User_VehicleID",
                table: "DetailVehicle_User",
                column: "VehicleID");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "DetailVehicle_User");
        }
    }
}
