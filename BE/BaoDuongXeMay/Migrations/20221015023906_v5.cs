using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace BaoDuongXeMay.Migrations
{
    public partial class v5 : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "RepairDate",
                table: "DetailVehicle_User");

            migrationBuilder.CreateTable(
                name: "History",
                columns: table => new
                {
                    IdHistory = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    IDDetailNAU = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    IDDeatil = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    RepairDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    TotalCost = table.Column<float>(type: "real", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_History", x => x.IdHistory);
                    table.ForeignKey(
                        name: "FK_DetaillNAU_Histories",
                        column: x => x.IDDetailNAU,
                        principalTable: "DetailNAU",
                        principalColumn: "IDDetailNAU",
                        onDelete: ReferentialAction.NoAction);
                    table.ForeignKey(
                        name: "FK_DetailVehicleUser_Histories",
                        column: x => x.IDDeatil,
                        principalTable: "DetailVehicle_User",
                        principalColumn: "IDDeatil",
                        onDelete: ReferentialAction.NoAction);
                });

            migrationBuilder.CreateIndex(
                name: "IX_History_IDDeatil",
                table: "History",
                column: "IDDeatil");

            migrationBuilder.CreateIndex(
                name: "IX_History_IDDetailNAU",
                table: "History",
                column: "IDDetailNAU");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "History");

            migrationBuilder.AddColumn<DateTime>(
                name: "RepairDate",
                table: "DetailVehicle_User",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified));
        }
    }
}
